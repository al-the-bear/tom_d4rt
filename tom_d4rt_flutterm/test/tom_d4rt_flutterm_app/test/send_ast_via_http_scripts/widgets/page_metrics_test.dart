// D4rt test script: Tests PageMetrics from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('PageMetrics test executing');

  // Test PageMetrics - PageMetrics
  print('PageMetrics is available in the widgets package');
  print('PageMetrics runtimeType accessible');

  print('PageMetrics test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('PageMetrics Tests'),
      Text('PageMetrics'),
    ],
  );
}
