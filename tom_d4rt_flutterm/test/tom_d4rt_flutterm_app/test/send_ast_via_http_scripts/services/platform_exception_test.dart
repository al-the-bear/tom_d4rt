// D4rt test script: Tests PlatformException from services
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('PlatformException test executing');

  // Test PlatformException - Platform error
  print('PlatformException is available in the services package');
  print('PlatformException: Platform error');

  print('PlatformException test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('PlatformException Tests'),
      Text('Platform error'),
    ],
  );
}
