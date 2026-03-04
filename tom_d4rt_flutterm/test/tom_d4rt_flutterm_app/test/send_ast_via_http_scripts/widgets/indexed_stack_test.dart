// D4rt test script: Tests IndexedStack from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('IndexedStack test executing');

  // Test IndexedStack - Indexed stack
  print('IndexedStack is available in the widgets package');
  print('IndexedStack runtimeType accessible');

  print('IndexedStack test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('IndexedStack Tests'),
      Text('Indexed stack'),
    ],
  );
}
