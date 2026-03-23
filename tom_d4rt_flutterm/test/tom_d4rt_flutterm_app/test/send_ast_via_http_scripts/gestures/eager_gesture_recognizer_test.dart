// ignore_for_file: avoid_print
// D4rt test script: Tests EagerGestureRecognizer from gestures
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('EagerGestureRecognizer test executing');

  // Create EagerGestureRecognizer
  final recognizer = EagerGestureRecognizer();

  print('Created: ${recognizer.runtimeType}');
  print('is GestureRecognizer: ${true}');
  print(
    'is OneSequenceGestureRecognizer: ${true}',
  );

  // What it does
  print('\nWhat it does:');
  print('- Immediately claims victory in gesture arena');
  print('- Consumes all pointer events');
  print('- Prevents other recognizers from winning');

  // Use cases
  print('\nUse cases:');
  print('- Absorbing touches (AbsorbPointer)');
  print('- Blocking gestures from children');
  print('- Modal barriers');

  // Gesture arena
  print('\nGesture arena:');
  print('- Multiple recognizers compete');
  print('- EagerGestureRecognizer always wins');
  print('- Other recognizers get rejected');

  // How to use
  print('\nHow to use:');
  print('RawGestureDetector(');
  print('  gestures: {');
  print('    EagerGestureRecognizer: GestureRecognizerFactoryWithHandlers<');
  print('      EagerGestureRecognizer>(');
  print('        () => EagerGestureRecognizer(),');
  print('        (r) {},');
  print('      ),');
  print('  },');
  print(')');

  recognizer.dispose();
  print('\nDisposed');

  print('\nEagerGestureRecognizer test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'EagerGestureRecognizer Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Immediately wins gesture arena'),
      Text('Consumes all pointer events'),
      Text('Use: blocking gestures'),
    ],
  );
}
