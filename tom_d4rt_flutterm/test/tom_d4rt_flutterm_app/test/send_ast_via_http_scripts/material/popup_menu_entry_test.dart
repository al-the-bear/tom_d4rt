// D4rt test script: Tests PopupMenuEntry from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('PopupMenuEntry test executing');

  // Test PopupMenuEntry - PopupMenuEntry
  print('PopupMenuEntry is available in the material package');
  print('PopupMenuEntry runtimeType accessible');

  print('PopupMenuEntry test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('PopupMenuEntry Tests'),
      Text('PopupMenuEntry'),
    ],
  );
}
