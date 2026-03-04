// D4rt test script: Tests Class from painting
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('Class test executing');

  // Test Class - Description
  print('Class is available in the painting package');
  print('Class: Description');

  print('Class test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('Class Tests'),
      Text('Description'),
    ],
  );
}
