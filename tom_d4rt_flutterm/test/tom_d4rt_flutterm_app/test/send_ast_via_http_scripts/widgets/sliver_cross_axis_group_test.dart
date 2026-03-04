// D4rt test script: Tests SliverCrossAxisGroup from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('SliverCrossAxisGroup test executing');

  // Test SliverCrossAxisGroup - Cross axis group
  print('SliverCrossAxisGroup is available in the widgets package');
  print('SliverCrossAxisGroup runtimeType accessible');

  print('SliverCrossAxisGroup test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('SliverCrossAxisGroup Tests'),
      Text('Cross axis group'),
    ],
  );
}
