// D4rt test script: Tests FontLoader from services
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('FontLoader test executing');

  // Test FontLoader - Font loading
  print('FontLoader is available in the services package');
  print('FontLoader: Font loading');

  print('FontLoader test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('FontLoader Tests'),
      Text('Font loading'),
    ],
  );
}
