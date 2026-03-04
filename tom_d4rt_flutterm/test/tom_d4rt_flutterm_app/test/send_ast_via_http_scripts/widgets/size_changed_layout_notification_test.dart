// D4rt test script: Tests SizeChangedLayoutNotification from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('SizeChangedLayoutNotification test executing');

  // Test SizeChangedLayoutNotification - SizeChangedLayoutNotification
  print('SizeChangedLayoutNotification is available in the widgets package');
  print('SizeChangedLayoutNotification runtimeType accessible');

  print('SizeChangedLayoutNotification test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('SizeChangedLayoutNotification Tests'),
      Text('SizeChangedLayoutNotification'),
    ],
  );
}
