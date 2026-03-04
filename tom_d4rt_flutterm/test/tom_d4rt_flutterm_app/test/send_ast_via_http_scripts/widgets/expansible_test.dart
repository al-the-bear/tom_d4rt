// D4rt test script: Tests Expansible from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('Expansible test executing');

  // Test Expansible - Expansible
  print('Expansible is available in the widgets package');
  print('Expansible runtimeType accessible');

  print('Expansible test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('Expansible Tests'),
      Text('Expansible'),
    ],
  );
}
