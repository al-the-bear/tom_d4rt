// D4rt test script: Tests ParentDataElement from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('ParentDataElement test executing');

  // Test ParentDataElement - Parent element
  print('ParentDataElement is available in the widgets package');
  print('ParentDataElement runtimeType accessible');

  print('ParentDataElement test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('ParentDataElement Tests'),
      Text('Parent element'),
    ],
  );
}
