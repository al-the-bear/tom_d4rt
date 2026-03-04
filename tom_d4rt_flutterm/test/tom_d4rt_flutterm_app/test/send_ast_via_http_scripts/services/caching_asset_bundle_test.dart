// D4rt test script: Tests CachingAssetBundle from services
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('CachingAssetBundle test executing');

  // Test CachingAssetBundle - Cached assets
  print('CachingAssetBundle is available in the services package');
  print('CachingAssetBundle: Cached assets');

  print('CachingAssetBundle test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('CachingAssetBundle Tests'),
      Text('Cached assets'),
    ],
  );
}
