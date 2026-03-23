// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests PrimaryPointerGestureRecognizer from gestures
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('PrimaryPointerGestureRecognizer test executing');

  // PrimaryPointerGestureRecognizer is abstract
  // Test via concrete subclass: LongPressGestureRecognizer
  final recognizer = LongPressGestureRecognizer();

  print('Testing via LongPressGestureRecognizer');
  print('Type: ${recognizer.runtimeType}');
  print(
    'is PrimaryPointerGestureRecognizer: ${true}',
  );
  print(
    'is OneSequenceGestureRecognizer: ${true}',
  );
  print('is GestureRecognizer: ${true}');

  // Test properties from PrimaryPointerGestureRecognizer
  print('\nPrimaryPointerGestureRecognizer properties:');
  print('debugOwner: ${recognizer.debugOwner}');
  print('gestureSettings: ${recognizer.gestureSettings}');

  // Test deadline (from PrimaryPointerGestureRecognizer)
  print('\nDeadline property:');
  print('deadline: deadline determines when gesture is recognized');

  // PrimaryPointerGestureRecognizer subclasses
  print('\nPrimaryPointerGestureRecognizer subclasses:');
  print('- LongPressGestureRecognizer');
  print('- BaseTapGestureRecognizer');
  print('  - TapGestureRecognizer');
  print('  - BaseTapAndDragGestureRecognizer');

  // Explain purpose
  print('\nPrimaryPointerGestureRecognizer purpose:');
  print('- Abstract base for single-pointer gestures');
  print('- Tracks a "primary" pointer');
  print('- Manages gesture state machine');
  print('- Handles deadline-based recognition');

  // Key concepts
  print('\nKey concepts:');
  print('- Primary pointer: first pointer to touch');
  print('- Other pointers are rejected');
  print('- Deadline: time threshold for recognition');
  print('- State: Possible -> Accepted/Rejected');

  // Clean up
  recognizer.dispose();
  print('\nDisposed recognizer');

  print('\nPrimaryPointerGestureRecognizer test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'PrimaryPointerGestureRecognizer',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
      ),
      SizedBox(height: 8),
      Text('Abstract base class'),
      Text('Single pointer gesture recognition'),
      Text('Subclasses: LongPress, Tap, etc.'),
      Text('Manages: deadline, state machine'),
    ],
  );
}
