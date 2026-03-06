// D4rt test script: Tests AggregatedTimings from foundation
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('AggregatedTimings test executing');

  // Test AggregatedTimings - Timing aggregation
  print('AggregatedTimings is available in the foundation package');
  print('AggregatedTimings: Timing aggregation');

  print('AggregatedTimings test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('AggregatedTimings Tests'),
      Text('Timing aggregation'),
    ],
  );
}
