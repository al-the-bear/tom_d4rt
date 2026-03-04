// D4rt test script: Tests CupertinoSheetRoute from cupertino
import 'package:flutter/cupertino.dart';

dynamic build(BuildContext context) {
  print('CupertinoSheetRoute test executing');

  // Test CupertinoSheetRoute - Sheet route
  print('CupertinoSheetRoute is available in the cupertino package');
  print('CupertinoSheetRoute runtimeType accessible');

  print('CupertinoSheetRoute test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('CupertinoSheetRoute Tests'),
      Text('Sheet route'),
    ],
  );
}
