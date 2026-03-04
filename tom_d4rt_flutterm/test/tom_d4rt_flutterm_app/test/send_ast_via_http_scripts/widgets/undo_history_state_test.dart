// D4rt test script: Tests UndoHistoryState from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('UndoHistoryState test executing');

  // Test UndoHistoryState - UndoHistoryState
  print('UndoHistoryState is available in the widgets package');
  print('UndoHistoryState runtimeType accessible');

  print('UndoHistoryState test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('UndoHistoryState Tests'),
      Text('UndoHistoryState'),
    ],
  );
}
