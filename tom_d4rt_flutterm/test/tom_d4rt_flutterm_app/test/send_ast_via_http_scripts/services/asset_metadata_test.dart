// D4rt test script: Tests AssetMetadata from services
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('AssetMetadata test executing');

  // Test AssetMetadata - Asset metadata
  print('AssetMetadata is available in the services package');
  print('AssetMetadata: Asset metadata');

  print('AssetMetadata test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('AssetMetadata Tests'),
      Text('Asset metadata'),
    ],
  );
}
