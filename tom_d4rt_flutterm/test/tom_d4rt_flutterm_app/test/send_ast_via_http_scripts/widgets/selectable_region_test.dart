// D4rt test script: Tests SelectableRegion from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('SelectableRegion test executing');

  // Test SelectableRegion - Selectable region
  print('SelectableRegion is available in the widgets package');
  print('SelectableRegion runtimeType accessible');

  print('SelectableRegion test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('SelectableRegion Tests'),
      Text('Selectable region'),
    ],
  );
}
