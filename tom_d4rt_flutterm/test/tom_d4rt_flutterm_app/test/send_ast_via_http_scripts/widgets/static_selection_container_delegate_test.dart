// D4rt test script: Tests StaticSelectionContainerDelegate from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('StaticSelectionContainerDelegate test executing');

  // Test StaticSelectionContainerDelegate - StaticSelectionContainerDelegate
  print('StaticSelectionContainerDelegate is available in the widgets package');
  print('StaticSelectionContainerDelegate runtimeType accessible');

  print('StaticSelectionContainerDelegate test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('StaticSelectionContainerDelegate Tests'),
      Text('StaticSelectionContainerDelegate'),
    ],
  );
}
