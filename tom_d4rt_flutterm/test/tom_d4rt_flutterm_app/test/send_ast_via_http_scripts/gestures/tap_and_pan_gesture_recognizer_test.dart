// D4rt test script: Tests TapAndPanGestureRecognizer from gestures
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('TapAndPanGestureRecognizer test executing');

  // Create recognizer
  final recognizer = TapAndPanGestureRecognizer();

  print('Created: ${recognizer.runtimeType}');

  // Test type hierarchy
  print('\nType hierarchy:');
  print(
    'is BaseTapAndDragGestureRecognizer: ${recognizer is BaseTapAndDragGestureRecognizer}',
  );
  print('is GestureRecognizer: ${recognizer is GestureRecognizer}');

  // Test callback properties
  print('\nCallback properties:');
  print('onTapDown: ${recognizer.onTapDown}');
  print('onTapUp: ${recognizer.onTapUp}');
  print('onDragStart: ${recognizer.onDragStart}');
  print('onDragUpdate: ${recognizer.onDragUpdate}');
  print('onDragEnd: ${recognizer.onDragEnd}');

  // Set up callbacks
  int tapCount = 0;
  recognizer.onTapUp = (TapDragUpDetails details) {
    tapCount++;
    print('  Tap completed: count=$tapCount');
  };
  recognizer.onDragUpdate = (TapDragUpdateDetails details) {
    print('  Drag update: delta=${details.delta}');
  };
  recognizer.onDragEnd = (TapDragEndDetails details) {
    print('  Drag ended with velocity: ${details.velocity}');
  };

  print('\nCallbacks configured');
  print('onTapUp set: ${recognizer.onTapUp != null}');
  print('onDragUpdate set: ${recognizer.onDragUpdate != null}');
  print('onDragEnd set: ${recognizer.onDragEnd != null}');

  // Explain purpose
  print('\nTapAndPanGestureRecognizer purpose:');
  print('- Combined tap + pan (any direction) recognition');
  print('- Most flexible tap-and-drag recognizer');
  print('- Drag in any direction after tap');
  print('- Used for interactive canvas, maps, etc.');

  // Use cases
  print('\nUse cases:');
  print('- Map pan with tap-to-mark');
  print('- Drawing canvas with selection');
  print('- Image viewer with pan and tap');
  print('- Custom drag-and-drop with tap');

  // Comparison
  print('\nComparison with other recognizers:');
  print('- TapAndPanGestureRecognizer: any direction <- this');
  print('- TapAndHorizontalDragGestureRecognizer: horizontal only');

  // Clean up
  recognizer.dispose();
  print('\nDisposed recognizer');

  print('\nTapAndPanGestureRecognizer test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'TapAndPanGestureRecognizer Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
      SizedBox(height: 8),
      Text('Tap + pan (any direction)'),
      Text('Direction: omnidirectional'),
      Text('Use: maps, canvas, image viewers'),
    ],
  );
}
