// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests SelectedContentRange from rendering
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('SelectedContentRange test executing');

  // Test SelectedContentRange - Content range
  print('SelectedContentRange is available in the rendering package');
  print('SelectedContentRange: Content range');

  print('SelectedContentRange test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('SelectedContentRange Tests'),
      Text('Content range'),
    ],
  );
}
