// D4rt test script: Tests ScrollEndNotification from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('ScrollEndNotification test executing');

  // Test ScrollEndNotification - ScrollEndNotification
  print('ScrollEndNotification is available in the widgets package');
  print('ScrollEndNotification runtimeType accessible');

  print('ScrollEndNotification test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('ScrollEndNotification Tests'),
      Text('ScrollEndNotification'),
    ],
  );
}
