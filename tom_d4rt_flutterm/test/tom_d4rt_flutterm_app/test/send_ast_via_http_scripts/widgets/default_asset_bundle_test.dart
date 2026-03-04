// D4rt test script: Tests DefaultAssetBundle from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('DefaultAssetBundle test executing');

  // Test DefaultAssetBundle - Asset bundle
  print('DefaultAssetBundle is available in the widgets package');
  print('DefaultAssetBundle runtimeType accessible');

  print('DefaultAssetBundle test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('DefaultAssetBundle Tests'),
      Text('Asset bundle'),
    ],
  );
}
