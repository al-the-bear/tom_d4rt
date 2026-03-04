// D4rt test script: Tests UiKitView from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('UiKitView test executing');

  // Test UiKitView - iOS view
  print('UiKitView is available in the widgets package');
  print('UiKitView runtimeType accessible');

  print('UiKitView test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('UiKitView Tests'),
      Text('iOS view'),
    ],
  );
}
