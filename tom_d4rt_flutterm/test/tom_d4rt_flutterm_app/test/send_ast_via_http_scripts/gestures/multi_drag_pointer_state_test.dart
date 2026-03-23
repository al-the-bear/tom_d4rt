// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests MultiDragPointerState (abstract) from gestures
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('MultiDragPointerState test executing');

  // MultiDragPointerState is abstract - explain concept
  print('MultiDragPointerState is abstract');
  print('Tracks state of individual pointers in multi-drag');

  // Properties
  print('\nProperties:');
  print('- initialPosition: where touch started');
  print('- pendingDelta: accumulated movement');
  print('- kind: PointerDeviceKind');

  // Methods
  print('\nMethods:');
  print('- checkForResolutionAfterMove: check if should start drag');
  print('- accepted: called when drag accepted');
  print('- rejected: called when drag rejected');
  print('- dispose: clean up');

  // Subclasses
  print('\nConcrete subclasses (internal):');
  print('- _ImmediatePointerState');
  print('- _HorizontalPointerState');
  print('- _VerticalPointerState');
  print('- _DelayedPointerState');

  // Demonstrate via recognizer
  print('\nUsed by MultiDragGestureRecognizer:');
  final recognizer = ImmediateMultiDragGestureRecognizer();
  print('ImmediateMultiDrag creates pointer states internally');
  recognizer.dispose();

  // Lifecycle
  print('\nLifecycle:');
  print('1. Pointer down -> create state');
  print('2. Pointer move -> update pendingDelta');
  print('3. checkForResolutionAfterMove');
  print('4. accepted() or rejected()');
  print('5. dispose()');

  print('\nMultiDragPointerState test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'MultiDragPointerState Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Abstract pointer state tracker'),
      Text('Properties: initialPosition, pendingDelta'),
      Text('Used by: MultiDragGestureRecognizer'),
    ],
  );
}
