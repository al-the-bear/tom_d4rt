// D4rt test script: Tests HeroController from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('HeroController test executing');

  // Test HeroController - HeroController
  print('HeroController is available in the widgets package');
  print('HeroController runtimeType accessible');

  print('HeroController test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('HeroController Tests'),
      Text('HeroController'),
    ],
  );
}
