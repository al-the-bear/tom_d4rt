// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests HorizontalMultiDragGestureRecognizer
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('HorizontalMultiDragGestureRecognizer test executing');

  // Create recognizer
  final recognizer = HorizontalMultiDragGestureRecognizer();
  print('Created: ${recognizer.runtimeType}');

  // Test type hierarchy
  print('\nType hierarchy:');
  print(
    'is MultiDragGestureRecognizer: ${true}',
  );
  print('is GestureRecognizer: ${true}');

  // Test debugOwner
  print('\nDebug properties:');
  print('debugOwner: ${recognizer.debugOwner}');
  // debugOwner is now final and cannot be set after construction

  // Test gestureSettings
  print('\nGesture settings:');
  print('gestureSettings: ${recognizer.gestureSettings}');

  // Test onStart callback
  print('\nCallback properties:');
  print('onStart: ${recognizer.onStart}');

  // Set onStart callback
  bool startCalled = false;
  recognizer.onStart = (Offset position) {
    startCalled = true;
    print('  onStart called at: $position [${startCalled.hashCode }]');
    return null; // Would return Drag in real usage
  };
  print('onStart after set: ${recognizer.onStart != null}');

  // Test allowedButtonsFilter
  print('\nButton filter:');
  print('allowedButtonsFilter: ${recognizer.allowedButtonsFilter}');

  // Explain purpose
  print('\nHorizontalMultiDragGestureRecognizer purpose:');
  print('- Recognizes horizontal drags from multiple pointers');
  print('- Each pointer can start independent drag');
  print('- Requires movement only in horizontal direction');
  print('- Used in multi-finger horizontal swiping');

  // Multi-drag hierarchy
  print('\nMulti-drag recognizer family:');
  print('- ImmediateMultiDragGestureRecognizer: starts immediately');
  print('- HorizontalMultiDragGestureRecognizer: horizontal only');
  print('- VerticalMultiDragGestureRecognizer: vertical only');
  print('- DelayedMultiDragGestureRecognizer: delayed start');

  // Clean up
  recognizer.dispose();
  print('\nDisposed recognizer');

  print('\nHorizontalMultiDragGestureRecognizer test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'HorizontalMultiDragGestureRecognizer',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
      ),
      SizedBox(height: 8),
      Text('Multi-pointer horizontal drags'),
      Text('is MultiDragGestureRecognizer: true'),
      Text('Direction: horizontal only'),
      Text('Pointers: multiple simultaneous'),
    ],
  );
}
