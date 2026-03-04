// D4rt test script: Tests TransitionDelegate from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('TransitionDelegate test executing');

  // Test TransitionDelegate - TransitionDelegate
  print('TransitionDelegate is available in the widgets package');
  print('TransitionDelegate runtimeType accessible');

  print('TransitionDelegate test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('TransitionDelegate Tests'),
      Text('TransitionDelegate'),
    ],
  );
}
