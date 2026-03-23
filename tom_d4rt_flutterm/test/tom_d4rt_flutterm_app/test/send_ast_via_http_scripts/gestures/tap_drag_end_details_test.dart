// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests TapDragEndDetails from gestures
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('TapDragEndDetails test executing');

  // Create TapDragEndDetails
  final details = TapDragEndDetails(
    velocity: Velocity(pixelsPerSecond: Offset(100.0, 50.0)),
    primaryVelocity: 100.0,
    consecutiveTapCount: 1,
  );

  print('Created: ${details.runtimeType}');

  // Test velocity properties
  print('\nVelocity properties:');
  print('velocity: ${details.velocity}');
  print('velocity.pixelsPerSecond: ${details.velocity.pixelsPerSecond}');
  print('primaryVelocity: ${details.primaryVelocity}');

  // Test consecutive tap count
  print('\nConsecutive tap count:');
  print('consecutiveTapCount: ${details.consecutiveTapCount}');

  // Velocity meaning
  print('\nVelocity meaning:');
  print('- velocity: 2D velocity vector');
  print('- primaryVelocity: velocity along primary axis');
  print('- Used for fling animations');
  print('- null primaryVelocity if not primarily one axis');

  // Explain purpose
  print('\nTapDragEndDetails purpose:');
  print('- Details when drag ends in tap-and-drag');
  print('- Contains end velocity for fling');
  print('- Used with BaseTapAndDragGestureRecognizer');
  print('- Passed to onDragEnd callback');

  // TapDrag sequence
  print('\nTapDrag sequence:');
  print('1. TapDragDownDetails (pointer down)');
  print('2. TapDragStartDetails (drag begins)');
  print('3. TapDragUpdateDetails (drag updates)');
  print('4. TapDragEndDetails (drag ends) <- this');

  // Fling handling
  print('\nFling handling:');
  print('- Check velocity magnitude');
  print('- Start physics simulation if > threshold');
  print('- Use primaryVelocity for 1D scrolling');

  print('\nTapDragEndDetails test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'TapDragEndDetails Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Drag ended in tap-and-drag'),
      Text('velocity: ${details.velocity.pixelsPerSecond}'),
      Text('primaryVelocity: ${details.primaryVelocity}'),
      Text('consecutiveTapCount: ${details.consecutiveTapCount}'),
    ],
  );
}
