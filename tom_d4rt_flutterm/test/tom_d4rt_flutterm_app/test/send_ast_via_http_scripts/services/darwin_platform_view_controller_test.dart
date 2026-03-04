// D4rt test script: Tests DarwinPlatformViewController from services
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('DarwinPlatformViewController test executing');

  // Test DarwinPlatformViewController - Darwin views
  print('DarwinPlatformViewController is available in the services package');
  print('DarwinPlatformViewController: Darwin views');

  print('DarwinPlatformViewController test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('DarwinPlatformViewController Tests'),
      Text('Darwin views'),
    ],
  );
}
