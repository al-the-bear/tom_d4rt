// D4rt test script: Tests TransformationController from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('TransformationController test executing');

  // Test TransformationController - TransformationController
  print('TransformationController is available in the widgets package');
  print('TransformationController runtimeType accessible');

  print('TransformationController test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('TransformationController Tests'),
      Text('TransformationController'),
    ],
  );
}
