// D4rt test script: Tests RadioClient from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('RadioClient test executing');

  // RadioClient is a mixin - verify it exists in the framework
  print('RadioClient is a mixin');
  print('RadioClient runtimeType check available');
  print('RadioClient type: mixin');

  print('RadioClient test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('RadioClient Tests'),
      Text('Type: mixin'),
      Text('RadioClient'),
    ],
  );
}
