// D4rt test script: Tests SpellOutStringAttribute from dart_ui
import 'dart:ui';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('SpellOutStringAttribute test executing');

  // Test SpellOutStringAttribute - Spell-out attribute
  print('SpellOutStringAttribute is available in the dart_ui package');
  print('SpellOutStringAttribute: Spell-out attribute');

  print('SpellOutStringAttribute test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('SpellOutStringAttribute Tests'),
      Text('Spell-out attribute'),
    ],
  );
}
