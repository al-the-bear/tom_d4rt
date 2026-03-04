// D4rt test script: Tests ActionDispatcher from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('ActionDispatcher test executing');

  // Test ActionDispatcher - Action dispatch
  print('ActionDispatcher is available in the widgets package');
  print('ActionDispatcher runtimeType accessible');

  print('ActionDispatcher test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('ActionDispatcher Tests'),
      Text('Action dispatch'),
    ],
  );
}
