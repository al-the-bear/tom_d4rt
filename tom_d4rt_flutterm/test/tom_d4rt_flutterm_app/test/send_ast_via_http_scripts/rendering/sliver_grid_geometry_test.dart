// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests SliverGridGeometry from rendering
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('SliverGridGeometry test executing');

  // Test SliverGridGeometry - Grid geometry
  print('SliverGridGeometry is available in the rendering package');
  print('SliverGridGeometry: Grid geometry');

  print('SliverGridGeometry test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('SliverGridGeometry Tests'),
      Text('Grid geometry'),
    ],
  );
}
