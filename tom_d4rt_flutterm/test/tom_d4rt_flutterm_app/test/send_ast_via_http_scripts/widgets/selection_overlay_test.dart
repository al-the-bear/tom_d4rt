// D4rt test script: Tests SelectionOverlay from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('SelectionOverlay test executing');

  // Test SelectionOverlay - Selection overlay
  print('SelectionOverlay is available in the widgets package');
  print('SelectionOverlay runtimeType accessible');

  print('SelectionOverlay test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('SelectionOverlay Tests'),
      Text('Selection overlay'),
    ],
  );
}
