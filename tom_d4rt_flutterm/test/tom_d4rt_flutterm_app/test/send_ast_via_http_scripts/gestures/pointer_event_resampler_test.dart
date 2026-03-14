// D4rt test script: Tests PointerEventResampler from gestures
import 'dart:ui' as ui;
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('PointerEventResampler test executing');

  // Create PointerEventResampler
  final resampler = PointerEventResampler();
  print('Created: ${resampler.runtimeType}');

  // Test properties
  print('\nResampler properties:');
  print('hasPendingPosition: ${resampler.hasPendingPosition}');
  print('hasPosition: ${resampler.hasPosition}');

  // Create test event to add
  final testEvent = PointerMoveEvent(
    pointer: 1,
    position: Offset(100, 200),
    timeStamp: Duration(milliseconds: 100),
    kind: ui.PointerDeviceKind.touch,
  );

  // Add sample to resampler
  print('\nAdding move event sample:');
  resampler.addEvent(testEvent);
  print('hasPendingPosition: ${resampler.hasPendingPosition}');
  print('hasPosition: ${resampler.hasPosition}');

  // Add another sample
  final testEvent2 = PointerMoveEvent(
    pointer: 1,
    position: Offset(150, 250),
    timeStamp: Duration(milliseconds: 120),
    kind: ui.PointerDeviceKind.touch,
  );
  resampler.addEvent(testEvent2);
  print('\nAfter adding second event:');
  print('hasPendingPosition: ${resampler.hasPendingPosition}');

  // Purpose explanation
  print('\nPointerEventResampler purpose:');
  print('- Resamples pointer events to match frame timing');
  print('- Smooths out irregular input sampling');
  print('- Interpolates positions between samples');
  print('- Improves rendering smoothness');

  // Usage context
  print('\nResampling context:');
  print('- Input events arrive at irregular intervals');
  print('- Frame rendering needs consistent timing');
  print('- Resampler interpolates to frame boundaries');
  print('- Results in smoother visual feedback');

  // Methods
  print('\nKey methods:');
  print('- addEvent(PointerEvent): Add sample');
  print('- sample(Duration, Duration, callback): Get resampled events');
  print('- stop(callback): End sampling with final events');

  print('\nPointerEventResampler test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'PointerEventResampler Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Resamples events to frame timing'),
      Text('hasPendingPosition: ${resampler.hasPendingPosition}'),
      Text('hasPosition: ${resampler.hasPosition}'),
      Text('Purpose: Smooth input-to-render timing'),
    ],
  );
}
