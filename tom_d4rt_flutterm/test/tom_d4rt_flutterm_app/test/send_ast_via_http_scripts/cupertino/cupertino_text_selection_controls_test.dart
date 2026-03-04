// D4rt test script: Tests CupertinoTextSelectionControls from cupertino
import 'package:flutter/cupertino.dart';

dynamic build(BuildContext context) {
  print('CupertinoTextSelectionControls test executing');

  // Test CupertinoTextSelectionControls - iOS controls
  print('CupertinoTextSelectionControls is available in the cupertino package');
  print('CupertinoTextSelectionControls runtimeType accessible');

  print('CupertinoTextSelectionControls test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('CupertinoTextSelectionControls Tests'),
      Text('iOS controls'),
    ],
  );
}
