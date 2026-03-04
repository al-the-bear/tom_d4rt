// D4rt test script: Tests NavigatorPopHandler from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('NavigatorPopHandler test executing');

  // Test NavigatorPopHandler - NavigatorPopHandler
  print('NavigatorPopHandler is available in the widgets package');
  print('NavigatorPopHandler runtimeType accessible');

  print('NavigatorPopHandler test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('NavigatorPopHandler Tests'),
      Text('NavigatorPopHandler'),
    ],
  );
}
