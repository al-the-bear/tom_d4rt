// D4rt test script: Tests TapDragUpdateDetails from gestures
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('TapDragUpdateDetails test executing');

  // Create TapDragUpdateDetails
  final details = TapDragUpdateDetails(
    globalPosition: Offset(150.0, 250.0),
    localPosition: Offset(75.0, 125.0),
    delta: Offset(10.0, 15.0),
    offsetFromOrigin: Offset(50.0, 50.0),
    localOffsetFromOrigin: Offset(25.0, 25.0),
    kind: PointerDeviceKind.touch,
    consecutiveTapCount: 1,
  );

  print('Created: ${details.runtimeType}');

  // Test position properties
  print('\nPosition properties:');
  print('globalPosition: ${details.globalPosition}');
  print('localPosition: ${details.localPosition}');

  // Test delta properties
  print('\nDelta properties:');
  print('delta: ${details.delta}');
  print('offsetFromOrigin: ${details.offsetFromOrigin}');
  print('localOffsetFromOrigin: ${details.localOffsetFromOrigin}');

  // Test device info
  print('\nDevice info:');
  print('kind: ${details.kind}');

  // Test consecutive tap count
  print('\nConsecutive tap count:');
  print('consecutiveTapCount: ${details.consecutiveTapCount}');

  // Explain properties
  print('\nProperty meanings:');
  print('- delta: movement since last update');
  print('- offsetFromOrigin: total movement from start');
  print('- localOffsetFromOrigin: total in local coords');

  // Explain purpose
  print('\nTapDragUpdateDetails purpose:');
  print('- Details for drag update in tap-and-drag');
  print('- Contains current position and movement');
  print('- Called repeatedly during drag');
  print('- Used for continuous drag feedback');

  // TapDrag sequence
  print('\nTapDrag sequence:');
  print('1. TapDragDownDetails');
  print('2. TapDragStartDetails');
  print('3. TapDragUpdateDetails (repeated) <- this');
  print('4. TapDragEndDetails');

  print('\nTapDragUpdateDetails test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'TapDragUpdateDetails Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Drag update in tap-and-drag'),
      Text('delta: ${details.delta}'),
      Text('offsetFromOrigin: ${details.offsetFromOrigin}'),
      Text('Called: repeatedly during drag'),
    ],
  );
}
