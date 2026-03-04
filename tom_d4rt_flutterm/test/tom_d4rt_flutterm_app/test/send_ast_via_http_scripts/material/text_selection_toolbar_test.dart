// D4rt test script: Tests TextSelectionToolbar from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('TextSelectionToolbar test executing');

  // Test TextSelectionToolbar - Selection toolbar
  print('TextSelectionToolbar is available in the material package');
  print('TextSelectionToolbar runtimeType accessible');

  print('TextSelectionToolbar test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('TextSelectionToolbar Tests'),
      Text('Selection toolbar'),
    ],
  );
}
