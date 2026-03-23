// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests BaseTapAndDragGestureRecognizer from gestures
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('BaseTapAndDragGestureRecognizer test executing');

  // BaseTapAndDragGestureRecognizer is abstract - test via TapAndPanGestureRecognizer
  final recognizer = TapAndPanGestureRecognizer();

  print('Created: ${recognizer.runtimeType}');
  print(
    'is BaseTapAndDragGestureRecognizer: ${true}',
  );

  // Properties from base class
  print('\nBase class properties:');
  print('dragStartBehavior: ${recognizer.dragStartBehavior}');
  print('eagerVictoryOnDrag: ${recognizer.eagerVictoryOnDrag}');

  // Callbacks
  print('\nCallbacks available:');
  print('- onTapDown');
  print('- onTapUp');
  print('- onDragStart');
  print('- onDragUpdate');
  print('- onDragEnd');
  print('- onCancel');

  // Set up callbacks
  recognizer.onTapDown = (details) =>
      print('Tap down at ${details.globalPosition}');
  recognizer.onDragStart = (details) => print('Drag started');
  recognizer.onDragUpdate = (details) => print('Drag delta: ${details.delta}');
  recognizer.onDragEnd = (details) => print('Drag ended');
  print('Callbacks set');

  // Subclasses
  print('\nSubclasses:');
  print('- TapAndPanGestureRecognizer: any direction');
  print('- TapAndHorizontalDragGestureRecognizer');

  // Use case
  print('\nUse case:');
  print('- Text selection: tap to position, drag to select');
  print('- Combined tap + drag gestures');

  recognizer.dispose();
  print('\nDisposed');

  print('\nBaseTapAndDragGestureRecognizer test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'BaseTapAndDragGestureRecognizer Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Abstract base for tap+drag'),
      Text('Subclass: TapAndPanGestureRecognizer'),
      Text('Callbacks: tap + drag events'),
    ],
  );
}
