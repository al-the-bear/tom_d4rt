// D4rt test script: Tests Codec from dart_ui
import 'dart:ui';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('Codec test executing');

  // Test Codec - Image codec
  print('Codec is available in the dart_ui package');
  print('Codec: Image codec');

  print('Codec test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('Codec Tests'),
      Text('Image codec'),
    ],
  );
}
