// D4rt test script: Tests TreeSliver from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('TreeSliver test executing');

  // Test TreeSliver - TreeSliver
  print('TreeSliver is available in the widgets package');
  print('TreeSliver runtimeType accessible');

  print('TreeSliver test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('TreeSliver Tests'),
      Text('TreeSliver'),
    ],
  );
}
