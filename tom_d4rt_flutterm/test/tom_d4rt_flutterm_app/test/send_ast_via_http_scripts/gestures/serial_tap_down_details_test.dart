// ignore_for_file: avoid_print
// D4rt test script: Tests SerialTapDownDetails from gestures
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('SerialTapDownDetails test executing');

  // Create SerialTapDownDetails
  final details = SerialTapDownDetails(
    globalPosition: Offset(100.0, 200.0),
    localPosition: Offset(50.0, 100.0),
    kind: PointerDeviceKind.touch,
    buttons: kPrimaryButton,
    count: 1, // Second tap in sequence (0-indexed? check behavior)
  );

  print('Created: ${details.runtimeType}');

  // Test position properties
  print('\nPosition properties:');
  print('globalPosition: ${details.globalPosition}');
  print('localPosition: ${details.localPosition}');

  // Test device info
  print('\nDevice info:');
  print('kind: ${details.kind}');
  print('buttons: ${details.buttons}');

  // Test count
  print('\nCount property:');
  print('count: ${details.count}');
  print('count=0: first tap');
  print('count=1: second tap (double-tap)');
  print('count=2: third tap');

  // Explain purpose
  print('\nSerialTapDownDetails purpose:');
  print('- Details for serial (multi) tap down');
  print('- Contains position and tap count');
  print('- Used in onSerialTapDown callback');
  print('- Tracks sequential tap position');

  // Serial tap use cases
  print('\nSerial tap use cases:');
  print('- Double-tap to zoom (count=1)');
  print('- Triple-tap to select paragraph (count=2)');
  print('- Custom multi-tap gestures');

  // Related classes
  print('\nRelated classes:');
  print('- SerialTapDownDetails (tap started) <- this');
  print('- SerialTapUpDetails (tap completed)');
  print('- SerialTapCancelDetails (tap cancelled)');
  print('- SerialTapGestureRecognizer (recognizer)');

  print('\nSerialTapDownDetails test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'SerialTapDownDetails Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Serial tap down'),
      Text('globalPosition: ${details.globalPosition}'),
      Text('count: ${details.count}'),
      Text('kind: ${details.kind}'),
    ],
  );
}
