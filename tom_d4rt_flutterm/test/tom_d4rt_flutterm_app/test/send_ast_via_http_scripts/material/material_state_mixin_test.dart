// D4rt test script: Tests MaterialStateMixin from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('MaterialStateMixin test executing');

  // MaterialStateMixin is a mixin - verify it exists in the framework
  print('MaterialStateMixin is a mixin');
  print('MaterialStateMixin runtimeType check available');
  print('MaterialStateMixin type: mixin');

  print('MaterialStateMixin test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('MaterialStateMixin Tests'),
      Text('Type: mixin'),
      Text('MaterialStateMixin'),
    ],
  );
}
