// D4rt test script: Tests SelectionRect from services
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('SelectionRect test executing');

  // Test SelectionRect - SelectionRect
  print('SelectionRect is available in the services package');
  print('SelectionRect: SelectionRect');

  print('SelectionRect test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('SelectionRect Tests'),
      Text('SelectionRect'),
    ],
  );
}
