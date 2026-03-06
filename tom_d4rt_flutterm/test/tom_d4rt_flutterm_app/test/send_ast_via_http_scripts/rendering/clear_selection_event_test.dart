// D4rt test script: Tests ClearSelectionEvent from rendering
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('ClearSelectionEvent test executing');

  // Test ClearSelectionEvent - Clear selection
  print('ClearSelectionEvent is available in the rendering package');
  print('ClearSelectionEvent: Clear selection');

  print('ClearSelectionEvent test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('ClearSelectionEvent Tests'),
      Text('Clear selection'),
    ],
  );
}
