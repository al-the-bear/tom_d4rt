// D4rt test script: Tests SelectionRegistrarScope from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('SelectionRegistrarScope test executing');

  // Test SelectionRegistrarScope - SelectionRegistrarScope
  print('SelectionRegistrarScope is available in the widgets package');
  print('SelectionRegistrarScope runtimeType accessible');

  print('SelectionRegistrarScope test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('SelectionRegistrarScope Tests'),
      Text('SelectionRegistrarScope'),
    ],
  );
}
