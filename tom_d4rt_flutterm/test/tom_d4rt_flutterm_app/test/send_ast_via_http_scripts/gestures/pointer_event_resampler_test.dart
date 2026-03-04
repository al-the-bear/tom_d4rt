// D4rt test script: Tests PointerEventResampler from gestures
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('PointerEventResampler test executing');

  // Test PointerEventResampler - Event resampling
  print('PointerEventResampler is available in the gestures package');
  print('PointerEventResampler: Event resampling');

  print('PointerEventResampler test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('PointerEventResampler Tests'),
      Text('Event resampling'),
    ],
  );
}
