// D4rt test script: Tests ImmediateMultiDragGestureRecognizer
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('ImmediateMultiDragGestureRecognizer test executing');

  // Create recognizer
  final recognizer = ImmediateMultiDragGestureRecognizer();
  print('Created: ${recognizer.runtimeType}');

  // Test type hierarchy
  print('\nType hierarchy:');
  print(
    'is MultiDragGestureRecognizer: ${recognizer is MultiDragGestureRecognizer}',
  );
  print('is GestureRecognizer: ${recognizer is GestureRecognizer}');

  // Test debugOwner
  print('\nDebug properties:');
  print('debugOwner: ${recognizer.debugOwner}');
  recognizer.debugOwner = 'TestOwner';
  print('debugOwner after set: ${recognizer.debugOwner}');

  // Test gestureSettings
  print('\nGesture settings:');
  print('gestureSettings: ${recognizer.gestureSettings}');

  // Configure gesture settings
  recognizer.gestureSettings = DeviceGestureSettings(
    touchSlop: 18.0,
    panSlop: 36.0,
  );
  print('gestureSettings configured: ${recognizer.gestureSettings}');

  // Test onStart callback
  print('\nCallback properties:');
  print('onStart: ${recognizer.onStart}');

  // Set onStart callback
  recognizer.onStart = (Offset position) {
    print('  Drag started at: $position');
    return null; // Would return Drag in real usage
  };
  print('onStart after set: ${recognizer.onStart != null}');

  // Test allowedButtonsFilter
  print('\nButton filter:');
  print('allowedButtonsFilter: ${recognizer.allowedButtonsFilter}');

  // Explain purpose
  print('\nImmediateMultiDragGestureRecognizer purpose:');
  print('- Starts drag immediately on pointer down');
  print('- No waiting for movement threshold');
  print('- Supports multiple simultaneous drags');
  print('- Used for immediate response drag operations');

  // Comparison with other recognizers
  print('\nComparison:');
  print('Immediate: starts on down event (this one)');
  print('Delayed: waits a bit before triggering');
  print('Horizontal/Vertical: requires directional movement');

  // Clean up
  recognizer.dispose();
  print('\nDisposed recognizer');

  print('\nImmediateMultiDragGestureRecognizer test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'ImmediateMultiDragGestureRecognizer',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
      ),
      SizedBox(height: 8),
      Text('Starts drag immediately'),
      Text('No movement threshold'),
      Text('Multi-pointer support: true'),
      Text('Any direction: true'),
    ],
  );
}
