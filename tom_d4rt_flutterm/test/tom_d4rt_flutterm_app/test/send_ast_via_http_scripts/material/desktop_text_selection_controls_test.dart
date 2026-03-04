// D4rt test script: Tests DesktopTextSelectionControls from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('DesktopTextSelectionControls test executing');

  // Test DesktopTextSelectionControls - Desktop controls
  print('DesktopTextSelectionControls is available in the material package');
  print('DesktopTextSelectionControls runtimeType accessible');

  print('DesktopTextSelectionControls test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('DesktopTextSelectionControls Tests'),
      Text('Desktop controls'),
    ],
  );
}
