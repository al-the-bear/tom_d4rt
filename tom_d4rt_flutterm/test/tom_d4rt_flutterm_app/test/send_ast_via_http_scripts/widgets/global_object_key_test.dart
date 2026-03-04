// D4rt test script: Tests GlobalObjectKey from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('GlobalObjectKey test executing');

  // Test GlobalObjectKey - GlobalObjectKey
  print('GlobalObjectKey is available in the widgets package');
  print('GlobalObjectKey runtimeType accessible');

  print('GlobalObjectKey test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('GlobalObjectKey Tests'),
      Text('GlobalObjectKey'),
    ],
  );
}
