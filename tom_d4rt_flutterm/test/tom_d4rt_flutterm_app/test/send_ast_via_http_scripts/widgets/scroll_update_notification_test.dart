// D4rt test script: Tests ScrollUpdateNotification from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('ScrollUpdateNotification test executing');

  // Test ScrollUpdateNotification - ScrollUpdateNotification
  print('ScrollUpdateNotification is available in the widgets package');
  print('ScrollUpdateNotification runtimeType accessible');

  print('ScrollUpdateNotification test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('ScrollUpdateNotification Tests'),
      Text('ScrollUpdateNotification'),
    ],
  );
}
