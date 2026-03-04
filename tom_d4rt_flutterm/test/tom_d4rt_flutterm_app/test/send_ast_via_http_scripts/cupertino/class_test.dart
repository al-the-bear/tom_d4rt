// D4rt test script: Tests Class from cupertino
import 'package:flutter/cupertino.dart';

dynamic build(BuildContext context) {
  print('Class test executing');

  // Test Class - Description
  print('Class is available in the cupertino package');
  print('Class runtimeType accessible');

  print('Class test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('Class Tests'),
      Text('Description'),
    ],
  );
}
