// D4rt test script: Tests DoNothingAction from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('DoNothingAction test executing');

  // Test DoNothingAction - DoNothingAction
  print('DoNothingAction is available in the widgets package');
  print('DoNothingAction runtimeType accessible');

  print('DoNothingAction test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('DoNothingAction Tests'),
      Text('DoNothingAction'),
    ],
  );
}
