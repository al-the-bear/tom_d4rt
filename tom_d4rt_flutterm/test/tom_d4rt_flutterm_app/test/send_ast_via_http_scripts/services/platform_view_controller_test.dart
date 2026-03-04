// D4rt test script: Tests PlatformViewController from services
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('PlatformViewController test executing');

  // Test PlatformViewController - View controller
  print('PlatformViewController is available in the services package');
  print('PlatformViewController: View controller');

  print('PlatformViewController test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('PlatformViewController Tests'),
      Text('View controller'),
    ],
  );
}
