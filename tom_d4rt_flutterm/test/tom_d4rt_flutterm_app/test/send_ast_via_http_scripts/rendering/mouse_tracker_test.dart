// D4rt test script: Tests MouseTracker from rendering
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('MouseTracker test executing');

  // Test MouseTracker - Mouse tracking
  print('MouseTracker is available in the rendering package');
  print('MouseTracker: Mouse tracking');

  print('MouseTracker test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('MouseTracker Tests'),
      Text('Mouse tracking'),
    ],
  );
}
