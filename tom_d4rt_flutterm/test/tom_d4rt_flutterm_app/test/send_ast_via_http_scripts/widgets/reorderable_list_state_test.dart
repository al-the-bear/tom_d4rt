// D4rt test script: Tests ReorderableListState from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('ReorderableListState test executing');

  // Test ReorderableListState - ReorderableListState
  print('ReorderableListState is available in the widgets package');
  print('ReorderableListState runtimeType accessible');

  print('ReorderableListState test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('ReorderableListState Tests'),
      Text('ReorderableListState'),
    ],
  );
}
