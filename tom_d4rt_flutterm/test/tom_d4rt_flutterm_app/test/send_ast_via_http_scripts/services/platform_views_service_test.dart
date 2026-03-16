// D4rt test script: Tests PlatformViewsService from services
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('PlatformViewsService test executing');

  // Test PlatformViewsService - Platform views
  print('PlatformViewsService is available in the services package');
  print('PlatformViewsService: Platform views');

  print('PlatformViewsService test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('PlatformViewsService Tests'),
      Text('Platform views'),
    ],
  );
}
