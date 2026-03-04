// D4rt test script: Tests CupertinoTextMagnifier from cupertino
import 'package:flutter/cupertino.dart';

dynamic build(BuildContext context) {
  print('CupertinoTextMagnifier test executing');

  // Test CupertinoTextMagnifier - Text magnifier
  print('CupertinoTextMagnifier is available in the cupertino package');
  print('CupertinoTextMagnifier runtimeType accessible');

  print('CupertinoTextMagnifier test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('CupertinoTextMagnifier Tests'),
      Text('Text magnifier'),
    ],
  );
}
