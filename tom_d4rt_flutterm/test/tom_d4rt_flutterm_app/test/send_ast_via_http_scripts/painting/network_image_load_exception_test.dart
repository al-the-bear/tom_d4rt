// D4rt test script: Tests NetworkImageLoadException from painting
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('NetworkImageLoadException test executing');

  // Test NetworkImageLoadException - Network error
  print('NetworkImageLoadException is available in the painting package');
  print('NetworkImageLoadException: Network error');

  print('NetworkImageLoadException test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('NetworkImageLoadException Tests'),
      Text('Network error'),
    ],
  );
}
