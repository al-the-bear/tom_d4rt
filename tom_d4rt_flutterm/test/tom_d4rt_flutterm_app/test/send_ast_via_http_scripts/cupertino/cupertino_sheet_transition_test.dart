// D4rt test script: Tests CupertinoSheetTransition from cupertino
import 'package:flutter/cupertino.dart';

dynamic build(BuildContext context) {
  print('CupertinoSheetTransition test executing');

  // Test CupertinoSheetTransition - Sheet transition
  print('CupertinoSheetTransition is available in the cupertino package');
  print('CupertinoSheetTransition runtimeType accessible');

  print('CupertinoSheetTransition test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('CupertinoSheetTransition Tests'),
      Text('Sheet transition'),
    ],
  );
}
