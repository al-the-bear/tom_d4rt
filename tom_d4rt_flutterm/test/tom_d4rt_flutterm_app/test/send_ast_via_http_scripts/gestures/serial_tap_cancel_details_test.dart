// D4rt test script: Tests SerialTapCancelDetails from gestures
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('SerialTapCancelDetails test executing');

  // Create SerialTapCancelDetails
  final details = SerialTapCancelDetails(count: 2);

  print('Created: ${details.runtimeType}');

  // Test count property
  print('\nCount property:');
  print('count: ${details.count}');
  print('Represents: number of previous taps in sequence');

  // Serial tap context
  print('\nSerial tap sequence:');
  print('1. First tap at count=0');
  print('2. Second tap at count=1');
  print('3. If cancelled, SerialTapCancelDetails has count');
  print('4. count=2 means this was going to be third tap');

  // Explain purpose
  print('\nSerialTapCancelDetails purpose:');
  print('- Details when serial tap is cancelled');
  print('- Contains count of previous successful taps');
  print('- Used in onSerialTapCancel callback');
  print('- Helps track interrupted tap sequences');

  // Cancellation reasons
  print('\nCancellation reasons:');
  print('- User moved finger too far');
  print('- Tap sequence timeout');
  print('- Another gesture won');
  print('- System interrupted gesture');

  // Related classes
  print('\nRelated classes:');
  print('- SerialTapDownDetails (tap started)');
  print('- SerialTapUpDetails (tap completed)');
  print('- SerialTapCancelDetails (tap cancelled) <- this');
  print('- SerialTapGestureRecognizer (recognizer)');

  print('\nSerialTapCancelDetails test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'SerialTapCancelDetails Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Serial tap cancelled'),
      Text('count: ${details.count}'),
      Text('Previous taps before cancel'),
      Text('Used in: onSerialTapCancel'),
    ],
  );
}
