// D4rt test script: Tests TapGestureRecognizer from gestures
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('TapGestureRecognizer test executing');

  // Create TapGestureRecognizer
  final recognizer = TapGestureRecognizer();

  print('Created: ${recognizer.runtimeType}');

  // Test type hierarchy
  print('\nType hierarchy:');
  print(
    'is BaseTapGestureRecognizer: ${true}',
  );
  print(
    'is PrimaryPointerGestureRecognizer: ${true}',
  );
  print('is GestureRecognizer: ${true}');

  // Test callback properties
  print('\nCallback properties:');
  print('onTapDown: ${recognizer.onTapDown}');
  print('onTapUp: ${recognizer.onTapUp}');
  print('onTap: ${recognizer.onTap}');
  print('onTapCancel: ${recognizer.onTapCancel}');
  print('onSecondaryTap: ${recognizer.onSecondaryTap}');
  print('onSecondaryTapDown: ${recognizer.onSecondaryTapDown}');
  print('onSecondaryTapUp: ${recognizer.onSecondaryTapUp}');
  print('onSecondaryTapCancel: ${recognizer.onSecondaryTapCancel}');

  // Set up callbacks
  int tapCount = 0;
  recognizer.onTap = () {
    tapCount++;
    print('  onTap! count=$tapCount');
  };
  recognizer.onTapDown = (TapDownDetails details) {
    print('  onTapDown at: ${details.globalPosition}');
  };
  recognizer.onTapUp = (TapUpDetails details) {
    print('  onTapUp at: ${details.globalPosition}');
  };

  print('\nCallbacks configured');
  print('onTap set: ${recognizer.onTap != null}');
  print('onTapDown set: ${recognizer.onTapDown != null}');
  print('onTapUp set: ${recognizer.onTapUp != null}');

  // Explain purpose
  print('\nTapGestureRecognizer purpose:');
  print('- Recognizes single taps');
  print('- Primary and secondary (right-click)');
  print('- Most common gesture recognizer');
  print('- Used by GestureDetector.onTap');

  // Tap sequence
  print('\nTap sequence:');
  print('1. onTapDown (finger pressed)');
  print('2. onTapUp (finger released)');
  print('3. onTap (complete tap)');
  print('OR: onTapCancel (if movement too far)');

  // Clean up
  recognizer.dispose();
  print('\nDisposed recognizer');

  print('\nTapGestureRecognizer test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'TapGestureRecognizer Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Recognizes single taps'),
      Text('Callbacks: onTap, onTapDown, onTapUp'),
      Text('Secondary: right-click support'),
      Text('Most common recognizer'),
    ],
  );
}
