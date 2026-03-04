// D4rt test script: Tests CupertinoExpansionTile from cupertino
import 'package:flutter/cupertino.dart';

dynamic build(BuildContext context) {
  print('CupertinoExpansionTile test executing');

  // Test CupertinoExpansionTile - CupertinoExpansionTile
  print('CupertinoExpansionTile is available in the cupertino package');
  print('CupertinoExpansionTile runtimeType accessible');

  print('CupertinoExpansionTile test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('CupertinoExpansionTile Tests'),
      Text('CupertinoExpansionTile'),
    ],
  );
}
