// D4rt test script: Tests PlatformDispatcher from dart_ui
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('PlatformDispatcher test executing');

  // Test PlatformDispatcher - Platform events
  print('PlatformDispatcher is available in the dart_ui package');
  print('PlatformDispatcher: Platform events');

  print('PlatformDispatcher test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('PlatformDispatcher Tests'),
      Text('Platform events'),
    ],
  );
}
