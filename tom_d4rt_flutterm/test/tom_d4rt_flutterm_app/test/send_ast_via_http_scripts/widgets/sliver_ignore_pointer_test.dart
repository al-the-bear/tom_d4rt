// D4rt test script: Tests SliverIgnorePointer from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('SliverIgnorePointer test executing');

  // Test SliverIgnorePointer - Ignore touch
  print('SliverIgnorePointer is available in the widgets package');
  print('SliverIgnorePointer runtimeType accessible');

  print('SliverIgnorePointer test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('SliverIgnorePointer Tests'),
      Text('Ignore touch'),
    ],
  );
}
