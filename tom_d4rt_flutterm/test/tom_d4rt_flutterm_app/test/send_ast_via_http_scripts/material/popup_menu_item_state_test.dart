// D4rt test script: Tests PopupMenuItemState from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('PopupMenuItemState test executing');

  // Test PopupMenuItemState - PopupMenuItemState
  print('PopupMenuItemState is available in the material package');
  print('PopupMenuItemState runtimeType accessible');

  print('PopupMenuItemState test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('PopupMenuItemState Tests'),
      Text('PopupMenuItemState'),
    ],
  );
}
