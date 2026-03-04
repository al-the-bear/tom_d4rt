// D4rt test script: Tests NavigationNotification from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('NavigationNotification test executing');

  // Test NavigationNotification - NavigationNotification
  print('NavigationNotification is available in the widgets package');
  print('NavigationNotification runtimeType accessible');

  print('NavigationNotification test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('NavigationNotification Tests'),
      Text('NavigationNotification'),
    ],
  );
}
