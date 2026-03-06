// D4rt test script: Tests HitTestable from gestures
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('HitTestable test executing');

  // Test HitTestable - HitTestable
  print('HitTestable is available in the gestures package');
  print('HitTestable: HitTestable');

  print('HitTestable test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('HitTestable Tests'),
      Text('HitTestable'),
    ],
  );
}
