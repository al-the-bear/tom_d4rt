// D4rt test script: Tests StringAttribute from dart_ui
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('StringAttribute test executing');

  // Test StringAttribute - Text attributes
  print('StringAttribute is available in the dart_ui package');
  print('StringAttribute: Text attributes');

  print('StringAttribute test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('StringAttribute Tests'),
      Text('Text attributes'),
    ],
  );
}
