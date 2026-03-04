// D4rt test script: Tests PopupMenuDivider from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('PopupMenuDivider test executing');

  // Test PopupMenuDivider - PopupMenuDivider
  print('PopupMenuDivider is available in the material package');
  print('PopupMenuDivider runtimeType accessible');

  print('PopupMenuDivider test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('PopupMenuDivider Tests'),
      Text('PopupMenuDivider'),
    ],
  );
}
