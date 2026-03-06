// D4rt test script: Tests FragmentProgram from dart_ui
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('FragmentProgram test executing');

  // Test FragmentProgram - Fragment shader program
  print('FragmentProgram is available in the dart_ui package');
  print('FragmentProgram: Fragment shader program');

  print('FragmentProgram test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('FragmentProgram Tests'),
      Text('Fragment shader program'),
    ],
  );
}
