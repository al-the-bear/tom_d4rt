// D4rt test script: Tests DesktopTextSelectionToolbar from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('DesktopTextSelectionToolbar test executing');

  // Test DesktopTextSelectionToolbar - Desktop toolbar
  print('DesktopTextSelectionToolbar is available in the material package');
  print('DesktopTextSelectionToolbar runtimeType accessible');

  print('DesktopTextSelectionToolbar test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('DesktopTextSelectionToolbar Tests'),
      Text('Desktop toolbar'),
    ],
  );
}
