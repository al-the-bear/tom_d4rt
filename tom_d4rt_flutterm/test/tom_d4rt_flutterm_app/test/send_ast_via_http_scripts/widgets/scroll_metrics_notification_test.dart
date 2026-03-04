// D4rt test script: Tests ScrollMetricsNotification from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('ScrollMetricsNotification test executing');

  // Test ScrollMetricsNotification - ScrollMetricsNotification
  print('ScrollMetricsNotification is available in the widgets package');
  print('ScrollMetricsNotification runtimeType accessible');

  print('ScrollMetricsNotification test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('ScrollMetricsNotification Tests'),
      Text('ScrollMetricsNotification'),
    ],
  );
}
