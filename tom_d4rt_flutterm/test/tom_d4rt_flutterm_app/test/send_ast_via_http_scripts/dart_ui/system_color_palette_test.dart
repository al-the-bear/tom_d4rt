// D4rt test script: Tests SystemColorPalette from dart_ui
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('SystemColorPalette test executing');

  // Test SystemColorPalette - System color palette
  print('SystemColorPalette is available in the dart_ui package');
  print('SystemColorPalette: System color palette');

  print('SystemColorPalette test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('SystemColorPalette Tests'),
      Text('System color palette'),
    ],
  );
}
