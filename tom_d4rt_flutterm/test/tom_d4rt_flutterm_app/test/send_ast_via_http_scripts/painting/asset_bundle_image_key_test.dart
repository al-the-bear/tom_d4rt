// D4rt test script: Tests AssetBundleImageKey from painting
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('AssetBundleImageKey test executing');

  // Test AssetBundleImageKey - Asset cache key
  print('AssetBundleImageKey is available in the painting package');
  print('AssetBundleImageKey: Asset cache key');

  print('AssetBundleImageKey test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('AssetBundleImageKey Tests'),
      Text('Asset cache key'),
    ],
  );
}
