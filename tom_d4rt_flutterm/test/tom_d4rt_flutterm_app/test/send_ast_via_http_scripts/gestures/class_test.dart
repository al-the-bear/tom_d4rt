// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests gestures package class overview
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Gestures class test executing');
  print('=' * 50);

  // DragDownDetails
  final ddd = DragDownDetails(globalPosition: Offset(100, 200));
  print('\nDragDownDetails:');
  print('  globalPosition: ${ddd.globalPosition}');
  print('  localPosition: ${ddd.localPosition}');

  // DragStartDetails
  final dsd = DragStartDetails(globalPosition: Offset(50, 60));
  print('\nDragStartDetails:');
  print('  globalPosition: ${dsd.globalPosition}');
  print('  localPosition: ${dsd.localPosition}');

  // DragUpdateDetails
  final dud = DragUpdateDetails(globalPosition: Offset(150, 250), delta: Offset(5, 10));
  print('\nDragUpdateDetails:');
  print('  globalPosition: ${dud.globalPosition}');
  print('  delta: ${dud.delta}');
  print('  primaryDelta: ${dud.primaryDelta}');

  // DragEndDetails
  final ded = DragEndDetails(velocity: Velocity(pixelsPerSecond: Offset(100, 200)));
  print('\nDragEndDetails:');
  print('  velocity: ${ded.velocity}');
  print('  primaryVelocity: ${ded.primaryVelocity}');

  // TapDownDetails
  final tdd = TapDownDetails(globalPosition: Offset(75, 80));
  print('\nTapDownDetails:');
  print('  globalPosition: ${tdd.globalPosition}');
  print('  localPosition: ${tdd.localPosition}');
  print('  kind: ${tdd.kind}');

  // TapUpDetails
  final tud = TapUpDetails(globalPosition: Offset(75, 80), kind: PointerDeviceKind.touch);
  print('\nTapUpDetails:');
  print('  globalPosition: ${tud.globalPosition}');
  print('  localPosition: ${tud.localPosition}');
  print('  kind: ${tud.kind}');

  // Velocity
  final vel = Velocity(pixelsPerSecond: Offset(300, 400));
  print('\nVelocity:');
  print('  pixelsPerSecond: ${vel.pixelsPerSecond}');
  print('  clampMagnitude(0, 100): ${vel.clampMagnitude(0, 100).pixelsPerSecond}');
  print('  Velocity.zero: ${Velocity.zero}');

  // VelocityEstimate
  final estimate = VelocityEstimate(
    pixelsPerSecond: Offset(200, 300),
    confidence: 0.95,
    duration: Duration(milliseconds: 100),
    offset: Offset(20, 30),
  );
  print('\nVelocityEstimate:');
  print('  pixelsPerSecond: ${estimate.pixelsPerSecond}');
  print('  confidence: ${estimate.confidence}');
  print('  duration: ${estimate.duration}');
  print('  offset: ${estimate.offset}');

  // Gesture recognizers
  print('\nGesture Recognizers:');
  final tap = TapGestureRecognizer();
  print('  TapGestureRecognizer: ${tap.runtimeType}');
  tap.dispose();

  final longPress = LongPressGestureRecognizer();
  print('  LongPressGestureRecognizer: ${longPress.runtimeType}');
  longPress.dispose();

  final doubleTap = DoubleTapGestureRecognizer();
  print('  DoubleTapGestureRecognizer: ${doubleTap.runtimeType}');
  doubleTap.dispose();

  final scale = ScaleGestureRecognizer();
  print('  ScaleGestureRecognizer: ${scale.runtimeType}');
  scale.dispose();

  final pan = PanGestureRecognizer();
  print('  PanGestureRecognizer: ${pan.runtimeType}');
  pan.dispose();
  print('All recognizers created and disposed');

  // PointerDeviceKind
  print('\nPointerDeviceKind values:');
  for (final kind in PointerDeviceKind.values) {
    print('  ${kind.name}: index=${kind.index}');
  }

  print('\n' + '=' * 50);
  print('Gestures class test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'Gestures Class Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('DragDetails: Down, Start, Update, End'),
      Text('TapDetails: Down, Up'),
      Text('Velocity: ${vel.pixelsPerSecond}'),
      Text('VelocityEstimate: confidence=${estimate.confidence}'),
      Text('Recognizers: Tap, LongPress, DoubleTap, Scale, Pan'),
      Text('PointerDeviceKind: ${PointerDeviceKind.values.length} values'),
    ],
  );
}
