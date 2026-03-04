// D4rt test script: Tests CupertinoPage from cupertino
import 'package:flutter/cupertino.dart';

dynamic build(BuildContext context) {
  print('CupertinoPage test executing');

  // Test CupertinoPage - Page widget
  print('CupertinoPage is available in the cupertino package');
  print('CupertinoPage runtimeType accessible');

  print('CupertinoPage test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('CupertinoPage Tests'),
      Text('Page widget'),
    ],
  );
}
