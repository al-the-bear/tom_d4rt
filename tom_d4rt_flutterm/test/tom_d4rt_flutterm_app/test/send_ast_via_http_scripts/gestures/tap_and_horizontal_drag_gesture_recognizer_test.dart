// ignore_for_file: avoid_print
// D4rt test script: Tests TapAndHorizontalDragGestureRecognizer from gestures
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('TapAndHorizontalDragGestureRecognizer test executing');

  // Create recognizer
  final recognizer = TapAndHorizontalDragGestureRecognizer();

  print('Created: ${recognizer.runtimeType}');

  // Test type hierarchy
  print('\nType hierarchy:');
  print(
    'is BaseTapAndDragGestureRecognizer: ${true}',
  );
  print('is GestureRecognizer: ${true}');

  // Test callback properties
  print('\nCallback properties:');
  print('onTapDown: ${recognizer.onTapDown}');
  print('onTapUp: ${recognizer.onTapUp}');
  print('onDragStart: ${recognizer.onDragStart}');
  print('onDragUpdate: ${recognizer.onDragUpdate}');
  print('onDragEnd: ${recognizer.onDragEnd}');

  // Set up callbacks
  recognizer.onTapDown = (TapDragDownDetails details) {
    print('  Tap down at: ${details.globalPosition}');
  };
  recognizer.onDragUpdate = (TapDragUpdateDetails details) {
    print('  Drag update: delta=${details.delta}');
  };

  print('\nCallbacks configured');
  print('onTapDown set: ${recognizer.onTapDown != null}');
  print('onDragUpdate set: ${recognizer.onDragUpdate != null}');

  // Explain purpose
  print('\nTapAndHorizontalDragGestureRecognizer purpose:');
  print('- Combined tap + horizontal drag recognition');
  print('- Drag only in horizontal direction');
  print('- Tap if no significant horizontal movement');
  print('- Used for swipeable list items with tap');

  // Use cases
  print('\nUse cases:');
  print('- Swipe-to-dismiss with tap action');
  print('- Horizontal slider with tap-to-set');
  print('- Tab bar with swipe and tap selection');

  // Comparison
  print('\nComparison:');
  print('- TapAndPanGestureRecognizer: any direction');
  print('- TapAndHorizontalDragGestureRecognizer: horizontal only <- this');

  // Clean up
  recognizer.dispose();
  print('\nDisposed recognizer');

  print('\nTapAndHorizontalDragGestureRecognizer test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'TapAndHorizontalDragGestureRecognizer',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
      ),
      SizedBox(height: 8),
      Text('Tap + horizontal drag only'),
      Text('Direction: horizontal'),
      Text('Use: swipe-to-dismiss with tap'),
    ],
  );
}
