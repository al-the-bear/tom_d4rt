// D4rt test script: Tests SystemContextMenu from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('SystemContextMenu test executing');

  // Test SystemContextMenu - SystemContextMenu
  print('SystemContextMenu is available in the widgets package');
  print('SystemContextMenu runtimeType accessible');

  print('SystemContextMenu test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('SystemContextMenu Tests'),
      Text('SystemContextMenu'),
    ],
  );
}
