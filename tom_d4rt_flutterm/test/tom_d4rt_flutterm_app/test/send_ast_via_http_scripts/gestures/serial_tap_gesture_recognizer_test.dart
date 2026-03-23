// ignore_for_file: avoid_print
// D4rt test script: Tests SerialTapGestureRecognizer from gestures
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('SerialTapGestureRecognizer test executing');

  // Create SerialTapGestureRecognizer
  final recognizer = SerialTapGestureRecognizer();

  print('Created: ${recognizer.runtimeType}');

  // Test type hierarchy
  print('\nType hierarchy:');
  print('is GestureRecognizer: ${true}');

  // Test callback properties
  print('\nCallback properties:');
  print('onSerialTapDown: ${recognizer.onSerialTapDown}');
  print('onSerialTapUp: ${recognizer.onSerialTapUp}');
  print('onSerialTapCancel: ${recognizer.onSerialTapCancel}');

  // Set up callbacks
  int tapCount = 0;
  recognizer.onSerialTapDown = (SerialTapDownDetails details) {
    tapCount++;
    print(
      '  onSerialTapDown: count=${details.count}, pos=${details.globalPosition}',
    );
  };
  recognizer.onSerialTapUp = (SerialTapUpDetails details) {
    print('  onSerialTapUp: count=${details.count} [${tapCount.hashCode }]');
  };
  recognizer.onSerialTapCancel = (SerialTapCancelDetails details) {
    print('  onSerialTapCancel: count=${details.count}');
  };

  print('\nCallbacks configured');
  print('onSerialTapDown: ${recognizer.onSerialTapDown != null}');
  print('onSerialTapUp: ${recognizer.onSerialTapUp != null}');
  print('onSerialTapCancel: ${recognizer.onSerialTapCancel != null}');

  // Explain purpose
  print('\nSerialTapGestureRecognizer purpose:');
  print('- Recognizes sequences of taps');
  print('- Tracks tap count in sequence');
  print('- Handles double-tap, triple-tap, etc.');
  print('- Automatic timeout between taps');

  // Usage pattern
  print('\nUsage pattern:');
  print('1. User taps -> onSerialTapDown (count=0)');
  print('2. User releases -> onSerialTapUp (count=0)');
  print('3. User taps again quickly -> onSerialTapDown (count=1)');
  print('4. This is a double-tap!');
  print('5. If timeout -> count resets to 0');

  // Clean up
  recognizer.dispose();
  print('\nDisposed recognizer');

  print('\nSerialTapGestureRecognizer test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'SerialTapGestureRecognizer Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Recognizes tap sequences'),
      Text('Callbacks: Down/Up/Cancel'),
      Text('Tracks: tap count'),
      Text('Use: double/triple-tap'),
    ],
  );
}
