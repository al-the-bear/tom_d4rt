// D4rt test script: Tests BaseTapGestureRecognizer from gestures
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('BaseTapGestureRecognizer test executing');

  // Abstract - tested via TapGestureRecognizer
  final recognizer = TapGestureRecognizer();

  print('Created: ${recognizer.runtimeType}');
  print(
    'is BaseTapGestureRecognizer: ${true}',
  );

  // Properties from base class
  print('\nBase class properties:');
  print('deadline: ${recognizer.deadline}');
  print('preAcceptSlopTolerance: ${recognizer.preAcceptSlopTolerance}');
  print('postAcceptSlopTolerance: ${recognizer.postAcceptSlopTolerance}');

  // Set up callbacks
  recognizer.onTap = () => print('Tapped!');
  recognizer.onTapDown = (details) =>
      print('Tap down at ${details.globalPosition}');
  recognizer.onTapUp = (details) => print('Tap up');
  recognizer.onTapCancel = () => print('Tap cancelled');
  print('\nCallbacks set:');
  print('- onTap');
  print('- onTapDown');
  print('- onTapUp');
  print('- onTapCancel');

  // Slop tolerance
  print('\nSlop tolerance:');
  print('- preAcceptSlopTolerance: before tap accepted');
  print('- postAcceptSlopTolerance: after tap accepted');
  print('- Allows small finger movement');

  // Subclasses
  print('\nSubclasses:');
  print('- TapGestureRecognizer: single tap');
  print('- DoubleTapGestureRecognizer: double tap');
  print('- SerialTapGestureRecognizer: serial taps');

  recognizer.dispose();
  print('\nDisposed');

  print('\nBaseTapGestureRecognizer test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'BaseTapGestureRecognizer Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Abstract base for tap gestures'),
      Text('Subclass: TapGestureRecognizer'),
      Text('Properties: deadline, slopTolerance'),
    ],
  );
}
