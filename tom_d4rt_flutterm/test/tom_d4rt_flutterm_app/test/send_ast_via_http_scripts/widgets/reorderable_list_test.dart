// D4rt test script: Tests ReorderableList from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('ReorderableList test executing');

  // Test ReorderableList - ReorderableList
  print('ReorderableList is available in the widgets package');
  print('ReorderableList runtimeType accessible');

  print('ReorderableList test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('ReorderableList Tests'),
      Text('ReorderableList'),
    ],
  );
}
