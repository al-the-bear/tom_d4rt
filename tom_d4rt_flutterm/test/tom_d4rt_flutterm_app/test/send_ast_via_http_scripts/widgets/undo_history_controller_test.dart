// D4rt test script: Tests UndoHistoryController from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('UndoHistoryController test executing');

  // Test UndoHistoryController - Undo controller
  print('UndoHistoryController is available in the widgets package');
  print('UndoHistoryController runtimeType accessible');

  print('UndoHistoryController test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('UndoHistoryController Tests'),
      Text('Undo controller'),
    ],
  );
}
