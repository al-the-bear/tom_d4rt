// D4rt test script: Tests TapAndDragGestureRecognizer from gestures
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('TapAndDragGestureRecognizer test executing');

  // TapAndDragGestureRecognizer is abstract, use concrete subclass
  final recognizer = TapAndPanGestureRecognizer();

  print('Testing via TapAndPanGestureRecognizer');
  print('Type: ${recognizer.runtimeType}');
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
  recognizer.onTapDown = (TapDragDownDetails details) {
    print('  onTapDown: pos=${details.globalPosition}');
  };
  recognizer.onDragStart = (TapDragStartDetails details) {
    print('  onDragStart: pos=${details.globalPosition}');
  };

  print('\nCallbacks configured');

  // Explain purpose
  print('\nTapAndDragGestureRecognizer purpose:');
  print('- Base class for combined tap+drag gestures');
  print('- Recognizes both tap and drag from same touch');
  print('- Decides based on movement threshold');
  print('- Allows tap-then-drag interaction');

  // Subclasses
  print('\nConcrete subclasses:');
  print('- TapAndPanGestureRecognizer: any direction');
  print('- TapAndHorizontalDragGestureRecognizer: horizontal');

  // Gesture flow
  print('\nGesture flow:');
  print('1. Touch down -> onTapDown');
  print('2. Small move -> still tap');
  print('3. Large move -> becomes drag');
  print('4. Touch up (no drag) -> onTapUp');
  print('5. If dragged -> onDragEnd');

  // Clean up
  recognizer.dispose();
  print('\nDisposed recognizer');

  print('\nTapAndDragGestureRecognizer test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'TapAndDragGestureRecognizer',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
      ),
      SizedBox(height: 8),
      Text('Combined tap + drag recognition'),
      Text('Base: BaseTapAndDragGestureRecognizer'),
      Text('Subclasses: TapAndPan, TapAndHorizontal'),
      Text('Flow: tap -> optional drag'),
    ],
  );
}
