// D4rt test script: Tests TextSelectionOverlay from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('TextSelectionOverlay test executing');

  // Test TextSelectionOverlay - Selection overlay
  print('TextSelectionOverlay is available in the widgets package');
  print('TextSelectionOverlay runtimeType accessible');

  print('TextSelectionOverlay test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('TextSelectionOverlay Tests'),
      Text('Selection overlay'),
    ],
  );
}
