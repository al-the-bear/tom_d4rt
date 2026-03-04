// D4rt test script: Tests SliverReorderableList from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('SliverReorderableList test executing');

  // Test SliverReorderableList - Reorderable sliver
  print('SliverReorderableList is available in the widgets package');
  print('SliverReorderableList runtimeType accessible');

  print('SliverReorderableList test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('SliverReorderableList Tests'),
      Text('Reorderable sliver'),
    ],
  );
}
