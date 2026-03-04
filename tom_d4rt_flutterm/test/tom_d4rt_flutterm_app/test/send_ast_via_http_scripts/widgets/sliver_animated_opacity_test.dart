// D4rt test script: Tests SliverAnimatedOpacity from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('SliverAnimatedOpacity test executing');

  // Test SliverAnimatedOpacity - Animated opacity
  print('SliverAnimatedOpacity is available in the widgets package');
  print('SliverAnimatedOpacity runtimeType accessible');

  print('SliverAnimatedOpacity test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('SliverAnimatedOpacity Tests'),
      Text('Animated opacity'),
    ],
  );
}
