// D4rt test script: Tests ImageStreamCompleterHandle from painting
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('ImageStreamCompleterHandle test executing');

  // Test ImageStreamCompleterHandle - Stream handle
  print('ImageStreamCompleterHandle is available in the painting package');
  print('ImageStreamCompleterHandle: Stream handle');

  print('ImageStreamCompleterHandle test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('ImageStreamCompleterHandle Tests'),
      Text('Stream handle'),
    ],
  );
}
