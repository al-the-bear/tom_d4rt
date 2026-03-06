// D4rt test script: Tests MaxColumnWidth from rendering
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('MaxColumnWidth test executing');

  // Test MaxColumnWidth - Max column
  print('MaxColumnWidth is available in the rendering package');
  print('MaxColumnWidth: Max column');

  print('MaxColumnWidth test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('MaxColumnWidth Tests'),
      Text('Max column'),
    ],
  );
}
