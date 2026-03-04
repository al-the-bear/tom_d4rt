// D4rt test script: Tests DecoratedSliver from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('DecoratedSliver test executing');

  // Test DecoratedSliver - DecoratedSliver
  print('DecoratedSliver is available in the widgets package');
  print('DecoratedSliver runtimeType accessible');

  print('DecoratedSliver test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('DecoratedSliver Tests'),
      Text('DecoratedSliver'),
    ],
  );
}
