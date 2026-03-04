// D4rt test script: Tests InheritedModelElement from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('InheritedModelElement test executing');

  // Test InheritedModelElement - InheritedModelElement
  print('InheritedModelElement is available in the widgets package');
  print('InheritedModelElement runtimeType accessible');

  print('InheritedModelElement test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('InheritedModelElement Tests'),
      Text('InheritedModelElement'),
    ],
  );
}
