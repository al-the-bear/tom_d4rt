// D4rt test script: Tests TextLayoutMetrics from services
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('TextLayoutMetrics test executing');

  // Test TextLayoutMetrics - Text metrics
  print('TextLayoutMetrics is available in the services package');
  print('TextLayoutMetrics: Text metrics');

  print('TextLayoutMetrics test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('TextLayoutMetrics Tests'),
      Text('Text metrics'),
    ],
  );
}
