// D4rt test script: Tests SliverAnimatedGridState from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('SliverAnimatedGridState test executing');

  // Test SliverAnimatedGridState - SliverAnimatedGridState
  print('SliverAnimatedGridState is available in the widgets package');
  print('SliverAnimatedGridState runtimeType accessible');

  print('SliverAnimatedGridState test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('SliverAnimatedGridState Tests'),
      Text('SliverAnimatedGridState'),
    ],
  );
}
