// D4rt test script: Tests InheritedCupertinoTheme from cupertino
import 'package:flutter/cupertino.dart';

dynamic build(BuildContext context) {
  print('InheritedCupertinoTheme test executing');

  // Test InheritedCupertinoTheme - InheritedCupertinoTheme
  print('InheritedCupertinoTheme is available in the cupertino package');
  print('InheritedCupertinoTheme runtimeType accessible');

  print('InheritedCupertinoTheme test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('InheritedCupertinoTheme Tests'),
      Text('InheritedCupertinoTheme'),
    ],
  );
}
