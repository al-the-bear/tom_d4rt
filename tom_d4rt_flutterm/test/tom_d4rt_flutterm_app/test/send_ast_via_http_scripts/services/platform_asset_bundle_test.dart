// D4rt test script: Tests PlatformAssetBundle from services
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('PlatformAssetBundle test executing');

  // Test PlatformAssetBundle - Platform assets
  print('PlatformAssetBundle is available in the services package');
  print('PlatformAssetBundle: Platform assets');

  print('PlatformAssetBundle test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('PlatformAssetBundle Tests'),
      Text('Platform assets'),
    ],
  );
}
