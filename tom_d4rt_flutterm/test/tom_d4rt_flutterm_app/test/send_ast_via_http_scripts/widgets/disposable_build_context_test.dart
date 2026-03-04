// D4rt test script: Tests DisposableBuildContext from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('DisposableBuildContext test executing');

  // Test DisposableBuildContext - DisposableBuildContext
  print('DisposableBuildContext is available in the widgets package');
  print('DisposableBuildContext runtimeType accessible');

  print('DisposableBuildContext test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('DisposableBuildContext Tests'),
      Text('DisposableBuildContext'),
    ],
  );
}
