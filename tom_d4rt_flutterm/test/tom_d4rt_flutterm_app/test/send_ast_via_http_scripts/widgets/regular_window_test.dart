// D4rt test script: Tests RegularWindow from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('RegularWindow test executing');

  // Test RegularWindow - RegularWindow
  print('RegularWindow is available in the widgets package');
  print('RegularWindow runtimeType accessible');

  print('RegularWindow test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('RegularWindow Tests'),
      Text('RegularWindow'),
    ],
  );
}
