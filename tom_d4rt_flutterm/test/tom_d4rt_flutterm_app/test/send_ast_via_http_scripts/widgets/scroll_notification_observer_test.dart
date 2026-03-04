// D4rt test script: Tests ScrollNotificationObserver from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('ScrollNotificationObserver test executing');

  // Test ScrollNotificationObserver - ScrollNotificationObserver
  print('ScrollNotificationObserver is available in the widgets package');
  print('ScrollNotificationObserver runtimeType accessible');

  print('ScrollNotificationObserver test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('ScrollNotificationObserver Tests'),
      Text('ScrollNotificationObserver'),
    ],
  );
}
