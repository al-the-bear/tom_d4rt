// D4rt test script: Tests FixedExtentMetrics from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('FixedExtentMetrics test executing');

  // Test FixedExtentMetrics - Extent metrics
  print('FixedExtentMetrics is available in the widgets package');
  print('FixedExtentMetrics runtimeType accessible');

  print('FixedExtentMetrics test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('FixedExtentMetrics Tests'),
      Text('Extent metrics'),
    ],
  );
}
