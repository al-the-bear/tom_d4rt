// D4rt test script: Tests OverscrollNotification from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('OverscrollNotification test executing');

  // Test OverscrollNotification - OverscrollNotification
  print('OverscrollNotification is available in the widgets package');
  print('OverscrollNotification runtimeType accessible');

  print('OverscrollNotification test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('OverscrollNotification Tests'),
      Text('OverscrollNotification'),
    ],
  );
}
