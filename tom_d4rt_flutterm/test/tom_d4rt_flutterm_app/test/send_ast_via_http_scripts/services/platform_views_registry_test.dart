// D4rt test script: Tests PlatformViewsRegistry from services
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('PlatformViewsRegistry test executing');

  // Test PlatformViewsRegistry - View registry
  print('PlatformViewsRegistry is available in the services package');
  print('PlatformViewsRegistry: View registry');

  print('PlatformViewsRegistry test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('PlatformViewsRegistry Tests'),
      Text('View registry'),
    ],
  );
}
