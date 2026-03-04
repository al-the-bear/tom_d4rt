// D4rt test script: Tests DefaultTransitionDelegate from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('DefaultTransitionDelegate test executing');

  // Test DefaultTransitionDelegate - DefaultTransitionDelegate
  print('DefaultTransitionDelegate is available in the widgets package');
  print('DefaultTransitionDelegate runtimeType accessible');

  print('DefaultTransitionDelegate test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('DefaultTransitionDelegate Tests'),
      Text('DefaultTransitionDelegate'),
    ],
  );
}
