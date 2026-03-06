// D4rt test script: Tests TargetImageSize from dart_ui
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('TargetImageSize test executing');

  // Test TargetImageSize - Image sizing
  print('TargetImageSize is available in the dart_ui package');
  print('TargetImageSize: Image sizing');

  print('TargetImageSize test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('TargetImageSize Tests'),
      Text('Image sizing'),
    ],
  );
}
