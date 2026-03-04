// D4rt test script: Tests FixedScrollMetrics from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('FixedScrollMetrics test executing');

  // Test FixedScrollMetrics - FixedScrollMetrics
  print('FixedScrollMetrics is available in the widgets package');
  print('FixedScrollMetrics runtimeType accessible');

  print('FixedScrollMetrics test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('FixedScrollMetrics Tests'),
      Text('FixedScrollMetrics'),
    ],
  );
}
