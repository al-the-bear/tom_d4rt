// ignore_for_file: avoid_print
// D4rt test script: Tests TapDragUpDetails from gestures
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('TapDragUpDetails test executing');

  // Create TapDragUpDetails
  final details = TapDragUpDetails(
    globalPosition: Offset(100.0, 200.0),
    localPosition: Offset(50.0, 100.0),
    kind: PointerDeviceKind.touch,
    consecutiveTapCount: 1,
  );

  print('Created: ${details.runtimeType}');

  // Test position properties
  print('\nPosition properties:');
  print('globalPosition: ${details.globalPosition}');
  print('localPosition: ${details.localPosition}');

  // Test device info
  print('\nDevice info:');
  print('kind: ${details.kind}');

  // Test consecutive tap count
  print('\nConsecutive tap count:');
  print('consecutiveTapCount: ${details.consecutiveTapCount}');

  // Explain purpose
  print('\nTapDragUpDetails purpose:');
  print('- Details for pointer up (tap) in tap-and-drag');
  print('- Called when tap completes without drag');
  print('- Contains final tap position');
  print('- Used to handle tap action');

  // Tap vs drag
  print('\nTap vs drag outcome:');
  print('If small movement:');
  print('  - TapDragDownDetails');
  print('  - TapDragUpDetails <- this (tap completed)');
  print('If large movement:');
  print('  - TapDragDownDetails');
  print('  - TapDragStartDetails');
  print('  - TapDragUpdateDetails...');
  print('  - TapDragEndDetails (drag completed)');

  // Use case
  print('\nUse case:');
  print('- User taps without dragging');
  print('- TapDragUpDetails received');
  print('- Handle as tap action');

  print('\nTapDragUpDetails test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'TapDragUpDetails Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Tap completed (no drag)'),
      Text('globalPosition: ${details.globalPosition}'),
      Text('consecutiveTapCount: ${details.consecutiveTapCount}'),
      Text('Alternative to: TapDragEndDetails'),
    ],
  );
}
