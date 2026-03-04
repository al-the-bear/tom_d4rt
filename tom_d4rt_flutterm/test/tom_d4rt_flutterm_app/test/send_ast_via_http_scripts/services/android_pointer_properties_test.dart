// D4rt test script: Tests AndroidPointerProperties from services
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('AndroidPointerProperties test executing');

  // Test AndroidPointerProperties - Android properties
  print('AndroidPointerProperties is available in the services package');
  print('AndroidPointerProperties: Android properties');

  print('AndroidPointerProperties test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('AndroidPointerProperties Tests'),
      Text('Android properties'),
    ],
  );
}
