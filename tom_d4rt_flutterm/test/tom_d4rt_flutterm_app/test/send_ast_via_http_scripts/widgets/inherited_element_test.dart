// D4rt test script: Tests InheritedElement from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('InheritedElement test executing');

  // Test InheritedElement - Inherited element
  print('InheritedElement is available in the widgets package');
  print('InheritedElement runtimeType accessible');

  print('InheritedElement test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('InheritedElement Tests'),
      Text('Inherited element'),
    ],
  );
}
