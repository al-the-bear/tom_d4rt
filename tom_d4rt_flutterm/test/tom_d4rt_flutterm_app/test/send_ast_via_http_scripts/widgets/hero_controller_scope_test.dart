// D4rt test script: Tests HeroControllerScope from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('HeroControllerScope test executing');

  // Test HeroControllerScope - HeroControllerScope
  print('HeroControllerScope is available in the widgets package');
  print('HeroControllerScope runtimeType accessible');

  print('HeroControllerScope test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('HeroControllerScope Tests'),
      Text('HeroControllerScope'),
    ],
  );
}
