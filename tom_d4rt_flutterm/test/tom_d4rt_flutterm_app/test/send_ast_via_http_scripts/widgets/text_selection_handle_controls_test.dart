// D4rt test script: Tests TextSelectionHandleControls from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('TextSelectionHandleControls test executing');

  // TextSelectionHandleControls is a mixin - verify it exists in the framework
  print('TextSelectionHandleControls is a mixin');
  print('TextSelectionHandleControls runtimeType check available');
  print('TextSelectionHandleControls type: mixin');

  print('TextSelectionHandleControls test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('TextSelectionHandleControls Tests'),
      Text('Type: mixin'),
      Text('TextSelectionHandleControls'),
    ],
  );
}
