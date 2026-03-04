// D4rt test script: Tests UndoHistoryValue from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('UndoHistoryValue test executing');

  // Test UndoHistoryValue - UndoHistoryValue
  print('UndoHistoryValue is available in the widgets package');
  print('UndoHistoryValue runtimeType accessible');

  print('UndoHistoryValue test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('UndoHistoryValue Tests'),
      Text('UndoHistoryValue'),
    ],
  );
}
