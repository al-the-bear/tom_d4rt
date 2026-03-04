// D4rt test script: Tests Category from foundation
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('Category test executing');

  // Test Category - Internal category
  print('Category is available in the foundation package');
  print('Category: Internal category');

  print('Category test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('Category Tests'),
      Text('Internal category'),
    ],
  );
}
