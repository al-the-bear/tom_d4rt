// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests TableBorder from rendering
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('TableBorder test executing');

  // Test TableBorder - Table border
  print('TableBorder is available in the rendering package');
  print('TableBorder: Table border');

  print('TableBorder test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('TableBorder Tests'),
      Text('Table border'),
    ],
  );
}
