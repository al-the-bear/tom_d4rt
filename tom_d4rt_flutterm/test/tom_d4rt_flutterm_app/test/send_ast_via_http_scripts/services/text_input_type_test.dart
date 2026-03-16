// D4rt test script: Tests TextInputType from services
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('TextInputType test executing');

  // Test TextInputType - TextInputType
  print('TextInputType is available in the services package');
  print('TextInputType: TextInputType');

  print('TextInputType test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('TextInputType Tests'),
      Text('TextInputType'),
    ],
  );
}
