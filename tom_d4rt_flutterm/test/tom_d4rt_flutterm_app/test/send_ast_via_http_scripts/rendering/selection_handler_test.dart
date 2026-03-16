// D4rt test script: Tests SelectionHandler from rendering
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('SelectionHandler test executing');

  // Test SelectionHandler - Selection handler
  print('SelectionHandler is available in the rendering package');
  print('SelectionHandler: Selection handler');

  print('SelectionHandler test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('SelectionHandler Tests'),
      Text('Selection handler'),
    ],
  );
}
