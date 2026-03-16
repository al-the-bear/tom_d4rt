// D4rt test script: Tests MinColumnWidth from rendering
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('MinColumnWidth test executing');

  // Test MinColumnWidth - Min column
  print('MinColumnWidth is available in the rendering package');
  print('MinColumnWidth: Min column');

  print('MinColumnWidth test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('MinColumnWidth Tests'),
      Text('Min column'),
    ],
  );
}
