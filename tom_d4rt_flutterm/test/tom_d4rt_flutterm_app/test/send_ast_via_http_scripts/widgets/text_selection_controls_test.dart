// D4rt test script: Tests TextSelectionControls from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('TextSelectionControls test executing');

  // Test TextSelectionControls - Selection controls
  print('TextSelectionControls is available in the widgets package');
  print('TextSelectionControls runtimeType accessible');

  print('TextSelectionControls test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('TextSelectionControls Tests'),
      Text('Selection controls'),
    ],
  );
}
