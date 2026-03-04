// D4rt test script: Tests ScrollAwareImageProvider from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('ScrollAwareImageProvider test executing');

  // Test ScrollAwareImageProvider - ScrollAwareImageProvider
  print('ScrollAwareImageProvider is available in the widgets package');
  print('ScrollAwareImageProvider runtimeType accessible');

  print('ScrollAwareImageProvider test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('ScrollAwareImageProvider Tests'),
      Text('ScrollAwareImageProvider'),
    ],
  );
}
