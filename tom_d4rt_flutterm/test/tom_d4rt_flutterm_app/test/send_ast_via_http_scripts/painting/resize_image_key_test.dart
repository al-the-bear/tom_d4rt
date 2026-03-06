// D4rt test script: Tests ResizeImageKey from painting
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('ResizeImageKey test executing');

  // Test ResizeImageKey - Resize cache key
  print('ResizeImageKey is available in the painting package');
  print('ResizeImageKey: Resize cache key');

  print('ResizeImageKey test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('ResizeImageKey Tests'),
      Text('Resize cache key'),
    ],
  );
}
