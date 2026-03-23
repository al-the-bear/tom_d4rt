// ignore_for_file: avoid_print
// D4rt test script: Tests SerialTapUpDetails from gestures
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('SerialTapUpDetails test executing');

  // Create SerialTapUpDetails
  final details = SerialTapUpDetails(
    globalPosition: Offset(100.0, 200.0),
    localPosition: Offset(50.0, 100.0),
    kind: PointerDeviceKind.touch,
    count: 1, // Second tap completed
  );

  print('Created: ${details.runtimeType}');

  // Test position properties
  print('\nPosition properties:');
  print('globalPosition: ${details.globalPosition}');
  print('localPosition: ${details.localPosition}');

  // Test device info
  print('\nDevice info:');
  print('kind: ${details.kind}');

  // Test count
  print('\nCount property:');
  print('count: ${details.count}');
  print('count=0: first tap completed');
  print('count=1: second tap completed (double-tap)');
  print('count=2: third tap completed');

  // Explain purpose
  print('\nSerialTapUpDetails purpose:');
  print('- Details for serial (multi) tap up');
  print('- Tap completed successfully');
  print('- Contains final position and tap count');
  print('- Used in onSerialTapUp callback');

  // Tap up vs tap down
  print('\nTap up vs tap down:');
  print('- SerialTapDownDetails: finger pressed');
  print('- SerialTapUpDetails: finger released <- this');
  print('- Both have same count for same tap');

  // Serial tap sequence
  print('\nDouble-tap sequence:');
  print('1. onSerialTapDown (count=0)');
  print('2. onSerialTapUp (count=0)');
  print('3. onSerialTapDown (count=1)');
  print('4. onSerialTapUp (count=1) <- this is double-tap!');

  print('\nSerialTapUpDetails test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'SerialTapUpDetails Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Serial tap up'),
      Text('globalPosition: ${details.globalPosition}'),
      Text('count: ${details.count}'),
      Text('kind: ${details.kind}'),
    ],
  );
}
