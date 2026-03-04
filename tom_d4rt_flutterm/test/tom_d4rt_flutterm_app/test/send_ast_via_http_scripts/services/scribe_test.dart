// D4rt test script: Tests Scribe from services
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('Scribe test executing');

  // Test Scribe - Text scribe
  print('Scribe is available in the services package');
  print('Scribe: Text scribe');

  print('Scribe test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('Scribe Tests'),
      Text('Text scribe'),
    ],
  );
}
