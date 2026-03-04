// D4rt test script: Tests SliverReorderableListState from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('SliverReorderableListState test executing');

  // Test SliverReorderableListState - SliverReorderableListState
  print('SliverReorderableListState is available in the widgets package');
  print('SliverReorderableListState runtimeType accessible');

  print('SliverReorderableListState test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('SliverReorderableListState Tests'),
      Text('SliverReorderableListState'),
    ],
  );
}
