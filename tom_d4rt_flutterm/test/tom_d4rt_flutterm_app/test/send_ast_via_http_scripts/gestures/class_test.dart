// ignore_for_file: avoid_print
// D4rt test script: Tests gestures package class overview
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Gestures class test executing');

  // DragDownDetails
  final ddd = DragDownDetails(globalPosition: Offset(100, 200));
  print('DragDownDetails: pos=${ddd.globalPosition}');

  // DragStartDetails
  final dsd = DragStartDetails(globalPosition: Offset(50, 60));
  print('DragStartDetails: pos=${dsd.globalPosition}');

  // DragUpdateDetails
  final dud = DragUpdateDetails(globalPosition: Offset(150, 250), delta: Offset(5, 10));
  print('DragUpdateDetails: delta=${dud.delta}');

  // DragEndDetails
  final ded = DragEndDetails(velocity: Velocity(pixelsPerSecond: Offset(100, 200)));
  print('DragEndDetails: velocity=${ded.velocity}');

  // Various recognizers (just create/dispose)
  TapGestureRecognizer().dispose();
  LongPressGestureRecognizer().dispose();
  DoubleTapGestureRecognizer().dispose();
  print('Recognizers created and disposed');

  // Velocity
  final vel = Velocity(pixelsPerSecond: Offset(300, 400));
  print('Velocity: ${vel.pixelsPerSecond}');
  print('clamp: ${vel.clampMagnitude(0, 100).pixelsPerSecond}');

  print('Gestures class test completed');
  return Column(mainAxisSize: MainAxisSize.min, children: [
    Text('Gestures Class Tests', style: TextStyle(fontWeight: FontWeight.bold)),
    Text('Detail classes: Drag/Tap/Long'),
    Text('Recognizers: Tap, LongPress, DoubleTap'),
    Text('Velocity: ${vel.pixelsPerSecond}'),
  ]);
}
