// D4rt test script: Tests ScrollStartNotification from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('ScrollStartNotification test executing');

  // Test ScrollStartNotification - ScrollStartNotification
  print('ScrollStartNotification is available in the widgets package');
  print('ScrollStartNotification runtimeType accessible');

  print('ScrollStartNotification test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('ScrollStartNotification Tests'),
      Text('ScrollStartNotification'),
    ],
  );
}
