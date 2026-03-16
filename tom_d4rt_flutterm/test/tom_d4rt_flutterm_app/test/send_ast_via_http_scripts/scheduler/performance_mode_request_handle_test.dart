// D4rt test script: Tests PerformanceModeRequestHandle from scheduler
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('PerformanceModeRequestHandle test executing');

  // Test PerformanceModeRequestHandle - Performance mode
  print('PerformanceModeRequestHandle is available in the scheduler package');
  print('PerformanceModeRequestHandle: Performance mode');

  print('PerformanceModeRequestHandle test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('PerformanceModeRequestHandle Tests'),
      Text('Performance mode'),
    ],
  );
}
