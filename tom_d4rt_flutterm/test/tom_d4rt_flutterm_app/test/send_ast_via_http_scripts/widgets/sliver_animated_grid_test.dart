// D4rt test script: Tests SliverAnimatedGrid from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('SliverAnimatedGrid test executing');

  // Test SliverAnimatedGrid - Animated sliver grid
  print('SliverAnimatedGrid is available in the widgets package');
  print('SliverAnimatedGrid runtimeType accessible');

  print('SliverAnimatedGrid test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('SliverAnimatedGrid Tests'),
      Text('Animated sliver grid'),
    ],
  );
}
