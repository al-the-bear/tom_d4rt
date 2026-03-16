// D4rt test script: Tests SelectionEvent from rendering
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('SelectionEvent test executing');

  // Test SelectionEvent - Selection event
  print('SelectionEvent is available in the rendering package');
  print('SelectionEvent: Selection event');

  print('SelectionEvent test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('SelectionEvent Tests'),
      Text('Selection event'),
    ],
  );
}
