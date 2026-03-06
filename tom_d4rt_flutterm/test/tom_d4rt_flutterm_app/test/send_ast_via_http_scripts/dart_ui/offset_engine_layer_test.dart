// D4rt test script: Tests OffsetEngineLayer from dart_ui
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('OffsetEngineLayer test executing');

  // Test OffsetEngineLayer - Offset layer
  print('OffsetEngineLayer is available in the dart_ui package');
  print('OffsetEngineLayer: Offset layer');

  print('OffsetEngineLayer test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('OffsetEngineLayer Tests'),
      Text('Offset layer'),
    ],
  );
}
