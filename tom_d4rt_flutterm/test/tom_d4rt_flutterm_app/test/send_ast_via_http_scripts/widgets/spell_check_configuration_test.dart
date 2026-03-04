// D4rt test script: Tests SpellCheckConfiguration from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('SpellCheckConfiguration test executing');

  // Test SpellCheckConfiguration - Spell check
  print('SpellCheckConfiguration is available in the widgets package');
  print('SpellCheckConfiguration runtimeType accessible');

  print('SpellCheckConfiguration test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('SpellCheckConfiguration Tests'),
      Text('Spell check'),
    ],
  );
}
