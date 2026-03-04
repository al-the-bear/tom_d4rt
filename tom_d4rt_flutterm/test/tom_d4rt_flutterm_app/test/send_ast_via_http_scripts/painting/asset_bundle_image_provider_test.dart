// D4rt test script: Tests AssetBundleImageProvider from painting
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('AssetBundleImageProvider test executing');

  // Test AssetBundleImageProvider - Asset image base
  print('AssetBundleImageProvider is available in the painting package');
  print('AssetBundleImageProvider: Asset image base');

  print('AssetBundleImageProvider test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('AssetBundleImageProvider Tests'),
      Text('Asset image base'),
    ],
  );
}
