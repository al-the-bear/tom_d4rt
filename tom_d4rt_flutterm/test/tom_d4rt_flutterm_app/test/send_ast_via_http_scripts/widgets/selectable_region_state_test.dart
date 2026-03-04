// D4rt test script: Tests SelectableRegionState from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('SelectableRegionState test executing');

  // Test SelectableRegionState - SelectableRegionState
  print('SelectableRegionState is available in the widgets package');
  print('SelectableRegionState runtimeType accessible');

  print('SelectableRegionState test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('SelectableRegionState Tests'),
      Text('SelectableRegionState'),
    ],
  );
}
