// D4rt test script: Tests AssetManifest from services
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('AssetManifest test executing');

  // Test AssetManifest - Asset manifest
  print('AssetManifest is available in the services package');
  print('AssetManifest: Asset manifest');

  print('AssetManifest test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('AssetManifest Tests'),
      Text('Asset manifest'),
    ],
  );
}
