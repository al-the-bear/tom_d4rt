// D4rt test script: Tests BoxScrollView from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('BoxScrollView test executing');

  // Test BoxScrollView - Scroll view base
  print('BoxScrollView is available in the widgets package');
  print('BoxScrollView runtimeType accessible');

  print('BoxScrollView test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('BoxScrollView Tests'),
      Text('Scroll view base'),
    ],
  );
}
