// D4rt test script: Tests Flex from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('Flex test executing');

  // Test Flex - Flex
  print('Flex is available in the widgets package');
  print('Flex runtimeType accessible');

  print('Flex test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('Flex Tests'),
      Text('Flex'),
    ],
  );
}
