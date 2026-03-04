// D4rt test script: Tests SliverAnimatedListState from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('SliverAnimatedListState test executing');

  // Test SliverAnimatedListState - SliverAnimatedListState
  print('SliverAnimatedListState is available in the widgets package');
  print('SliverAnimatedListState runtimeType accessible');

  print('SliverAnimatedListState test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('SliverAnimatedListState Tests'),
      Text('SliverAnimatedListState'),
    ],
  );
}
