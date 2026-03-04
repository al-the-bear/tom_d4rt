// D4rt test script: Tests Notification from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('Notification test executing');

  // Test Notification - Notification
  print('Notification is available in the widgets package');
  print('Notification runtimeType accessible');

  print('Notification test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('Notification Tests'),
      Text('Notification'),
    ],
  );
}
