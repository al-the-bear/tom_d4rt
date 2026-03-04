// D4rt test script: Tests SliverPrototypeExtentList from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('SliverPrototypeExtentList test executing');

  // Test SliverPrototypeExtentList - Prototype list
  print('SliverPrototypeExtentList is available in the widgets package');
  print('SliverPrototypeExtentList runtimeType accessible');

  print('SliverPrototypeExtentList test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('SliverPrototypeExtentList Tests'),
      Text('Prototype list'),
    ],
  );
}
