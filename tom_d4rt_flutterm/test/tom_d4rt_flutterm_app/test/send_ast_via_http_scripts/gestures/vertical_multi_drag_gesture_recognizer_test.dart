// D4rt test script: Tests VerticalMultiDragGestureRecognizer from gestures
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('VerticalMultiDragGestureRecognizer test executing');

  // Create VerticalMultiDragGestureRecognizer
  final recognizer = VerticalMultiDragGestureRecognizer();

  print('Created: ${recognizer.runtimeType}');

  // Test type hierarchy
  print('\nType hierarchy:');
  print(
    'is MultiDragGestureRecognizer: ${recognizer is MultiDragGestureRecognizer}',
  );
  print('is GestureRecognizer: ${recognizer is GestureRecognizer}');

  // Test callback property
  print('\nCallback property:');
  print('onStart: ${recognizer.onStart}');

  // Set up callback
  recognizer.onStart = (Offset position) {
    print('  Drag started at: $position');
    return null; // Would return Drag object in real use
  };
  print('onStart set: ${recognizer.onStart != null}');

  // Compare multi-drag recognizers
  print('\nMulti-drag recognizer comparison:');
  print('VerticalMultiDragGestureRecognizer: Only vertical drags');
  print('HorizontalMultiDragGestureRecognizer: Only horizontal drags');
  print('ImmediateMultiDragGestureRecognizer: Any direction, instant');
  print('DelayedMultiDragGestureRecognizer: Any direction, after delay');

  // Explain purpose
  print('\nVerticalMultiDragGestureRecognizer purpose:');
  print('- Recognizes vertical drag gestures');
  print('- Supports multiple simultaneous pointers');
  print('- Used for vertical lists, sliders');
  print('- Rejects horizontal movement');

  // Multi-pointer usage
  print('\nMulti-pointer usage:');
  print('- Each pointer gets separate drag');
  print('- Independent tracking per finger');
  print('- Useful for multi-touch scenarios');

  // Clean up
  recognizer.dispose();
  print('\nDisposed recognizer');

  print('\nVerticalMultiDragGestureRecognizer test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'VerticalMultiDragGestureRecognizer Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Vertical-only multi-drag'),
      Text('Multiple pointers supported'),
      Text('Rejects horizontal movement'),
      Text('Used for: vertical lists'),
    ],
  );
}
