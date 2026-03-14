// D4rt test script: Tests DelayedMultiDragGestureRecognizer
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('DelayedMultiDragGestureRecognizer test executing');

  // Create with default delay
  final recognizer = DelayedMultiDragGestureRecognizer();

  print('Created: ${recognizer.runtimeType}');
  print(
    'is MultiDragGestureRecognizer: ${recognizer is MultiDragGestureRecognizer}',
  );

  // Delay property
  print('\nDelay:');
  print('delay: ${recognizer.delay}');
  recognizer.dispose();

  // With custom delay
  print('\nCustom delay:');
  final r2 = DelayedMultiDragGestureRecognizer(
    delay: Duration(milliseconds: 500),
  );
  print('Custom delay: ${r2.delay}');
  r2.dispose();

  // How it works
  print('\nHow it works:');
  print('1. User touches screen');
  print('2. Waits for delay duration');
  print('3. If still touching, drag starts');
  print('4. Prevents accidental drags');

  // vs ImmediateMultiDragGestureRecognizer
  print('\nvs ImmediateMultiDrag:');
  print('- Immediate: starts drag immediately');
  print('- Delayed: waits before starting');
  print('- Delayed prevents scroll/drag conflicts');

  // Use case
  print('\nUse cases:');
  print('- Long-press to drag');
  print('- Reorderable lists');
  print('- Avoid accidental drags');

  // onStart callback
  print('\nonStart callback:');
  print('recognizer.onStart = (position) {');
  print('  return MyDrag();');
  print('};');

  print('\nDelayedMultiDragGestureRecognizer test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'DelayedMultiDragGestureRecognizer Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Multi-touch drag with delay'),
      Text('delay: configurable'),
      Text('Use: long-press to drag'),
    ],
  );
}
