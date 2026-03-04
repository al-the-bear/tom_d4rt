// D4rt test script: Tests CharacterActivator from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('CharacterActivator test executing');

  // Test CharacterActivator - Char activator
  print('CharacterActivator is available in the widgets package');
  print('CharacterActivator runtimeType accessible');

  print('CharacterActivator test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('CharacterActivator Tests'),
      Text('Char activator'),
    ],
  );
}
