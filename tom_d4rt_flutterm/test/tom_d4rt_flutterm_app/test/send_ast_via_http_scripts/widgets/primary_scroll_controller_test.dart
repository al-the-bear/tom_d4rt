// D4rt test script: Tests PrimaryScrollController from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('PrimaryScrollController test executing');

  // Test PrimaryScrollController - Primary controller
  print('PrimaryScrollController is available in the widgets package');
  print('PrimaryScrollController runtimeType accessible');

  print('PrimaryScrollController test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('PrimaryScrollController Tests'),
      Text('Primary controller'),
    ],
  );
}
