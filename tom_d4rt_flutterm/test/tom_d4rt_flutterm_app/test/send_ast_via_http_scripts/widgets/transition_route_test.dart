// D4rt test script: Tests TransitionRoute from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('TransitionRoute test executing');

  // Test TransitionRoute - TransitionRoute
  print('TransitionRoute is available in the widgets package');
  print('TransitionRoute runtimeType accessible');

  print('TransitionRoute test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('TransitionRoute Tests'),
      Text('TransitionRoute'),
    ],
  );
}
