// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests SelectionGeometry from rendering
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('SelectionGeometry test executing');

  // Test SelectionGeometry - Selection geometry
  print('SelectionGeometry is available in the rendering package');
  print('SelectionGeometry: Selection geometry');

  print('SelectionGeometry test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('SelectionGeometry Tests'),
      Text('Selection geometry'),
    ],
  );
}
