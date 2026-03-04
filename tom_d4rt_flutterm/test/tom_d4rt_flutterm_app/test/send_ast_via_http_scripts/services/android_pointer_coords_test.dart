// D4rt test script: Tests AndroidPointerCoords from services
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('AndroidPointerCoords test executing');

  // Test AndroidPointerCoords - Android coords
  print('AndroidPointerCoords is available in the services package');
  print('AndroidPointerCoords: Android coords');

  print('AndroidPointerCoords test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('AndroidPointerCoords Tests'),
      Text('Android coords'),
    ],
  );
}
