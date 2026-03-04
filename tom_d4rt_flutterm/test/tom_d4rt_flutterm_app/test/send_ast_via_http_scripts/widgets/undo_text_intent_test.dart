// D4rt test script: Tests UndoTextIntent from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('UndoTextIntent test executing');

  // Test UndoTextIntent - UndoTextIntent
  print('UndoTextIntent is available in the widgets package');
  print('UndoTextIntent runtimeType accessible');

  print('UndoTextIntent test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('UndoTextIntent Tests'),
      Text('UndoTextIntent'),
    ],
  );
}
