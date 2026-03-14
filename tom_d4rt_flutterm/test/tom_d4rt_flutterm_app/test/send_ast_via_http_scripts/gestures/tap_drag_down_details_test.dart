// D4rt test script: Tests TapDragDownDetails from gestures
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('TapDragDownDetails test executing');

  // Create TapDragDownDetails
  final details = TapDragDownDetails(
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
  print('1 = single tap, 2 = double tap, etc.');

  // Explain purpose
  print('\nTapDragDownDetails purpose:');
  print('- Details for pointer down in tap-and-drag');
  print('- Contains position and tap count');
  print('- Used with BaseTapAndDragGestureRecognizer');
  print('- Passed to onTapDown callback');

  // TapDrag details family
  print('\nTapDrag details family:');
  print('- TapDragDownDetails: pointer down <- this');
  print('- TapDragStartDetails: drag started');
  print('- TapDragUpdateDetails: drag update');
  print('- TapDragUpDetails: pointer up (tap complete)');
  print('- TapDragEndDetails: drag ended');

  // Consecutive tap use case
  print('\nConsecutive tap use case:');
  print('- consecutiveTapCount=1: single tap down');
  print('- consecutiveTapCount=2: double tap down');
  print('- Allows multi-tap-then-drag gestures');

  print('\nTapDragDownDetails test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'TapDragDownDetails Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Pointer down in tap-and-drag'),
      Text('globalPosition: ${details.globalPosition}'),
      Text('consecutiveTapCount: ${details.consecutiveTapCount}'),
      Text('kind: ${details.kind}'),
    ],
  );
}
