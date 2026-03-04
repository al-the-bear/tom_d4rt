// D4rt test script: Tests Priority from scheduler
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('Priority test executing');

  // Test Priority - Priority
  print('Priority is available in the scheduler package');
  print('Priority: Priority');

  print('Priority test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('Priority Tests'),
      Text('Priority'),
    ],
  );
}
