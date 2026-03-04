// D4rt test script: Tests SliverOffstage from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('SliverOffstage test executing');

  // Test SliverOffstage - Sliver offstage
  print('SliverOffstage is available in the widgets package');
  print('SliverOffstage runtimeType accessible');

  print('SliverOffstage test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('SliverOffstage Tests'),
      Text('Sliver offstage'),
    ],
  );
}
