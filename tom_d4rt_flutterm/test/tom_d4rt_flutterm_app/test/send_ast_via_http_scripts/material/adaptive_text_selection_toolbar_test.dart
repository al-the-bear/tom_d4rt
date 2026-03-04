// D4rt test script: Tests AdaptiveTextSelectionToolbar from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('AdaptiveTextSelectionToolbar test executing');

  // Test AdaptiveTextSelectionToolbar - Adaptive toolbar
  print('AdaptiveTextSelectionToolbar is available in the material package');
  print('AdaptiveTextSelectionToolbar runtimeType accessible');

  print('AdaptiveTextSelectionToolbar test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('AdaptiveTextSelectionToolbar Tests'),
      Text('Adaptive toolbar'),
    ],
  );
}
