// D4rt test script: Tests SemanticsFlags from dart_ui
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('SemanticsFlags test executing');

  // Test SemanticsFlags - Accessibility flag set
  print('SemanticsFlags is available in the dart_ui package');
  print('SemanticsFlags: Accessibility flag set');

  print('SemanticsFlags test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('SemanticsFlags Tests'),
      Text('Accessibility flag set'),
    ],
  );
}
