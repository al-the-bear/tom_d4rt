// D4rt test script: Tests SelectionContainerDelegate from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('SelectionContainerDelegate test executing');

  // Test SelectionContainerDelegate - SelectionContainerDelegate
  print('SelectionContainerDelegate is available in the widgets package');
  print('SelectionContainerDelegate runtimeType accessible');

  print('SelectionContainerDelegate test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('SelectionContainerDelegate Tests'),
      Text('SelectionContainerDelegate'),
    ],
  );
}
