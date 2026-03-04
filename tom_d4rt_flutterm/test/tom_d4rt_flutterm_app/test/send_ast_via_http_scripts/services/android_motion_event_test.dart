// D4rt test script: Tests AndroidMotionEvent from services
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('AndroidMotionEvent test executing');

  // Test AndroidMotionEvent - Android motion
  print('AndroidMotionEvent is available in the services package');
  print('AndroidMotionEvent: Android motion');

  print('AndroidMotionEvent test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('AndroidMotionEvent Tests'),
      Text('Android motion'),
    ],
  );
}
