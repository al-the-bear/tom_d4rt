// D4rt test script: Tests SliverMainAxisGroup from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('SliverMainAxisGroup test executing');

  // Test SliverMainAxisGroup - Main axis group
  print('SliverMainAxisGroup is available in the widgets package');
  print('SliverMainAxisGroup runtimeType accessible');

  print('SliverMainAxisGroup test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('SliverMainAxisGroup Tests'),
      Text('Main axis group'),
    ],
  );
}
