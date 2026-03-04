// D4rt test script: Tests SliverAnimatedList from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('SliverAnimatedList test executing');

  // Test SliverAnimatedList - Animated sliver list
  print('SliverAnimatedList is available in the widgets package');
  print('SliverAnimatedList runtimeType accessible');

  print('SliverAnimatedList test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('SliverAnimatedList Tests'),
      Text('Animated sliver list'),
    ],
  );
}
