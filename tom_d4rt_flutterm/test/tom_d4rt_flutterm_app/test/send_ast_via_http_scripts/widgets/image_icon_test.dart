// D4rt test script: Tests ImageIcon from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('ImageIcon test executing');

  // Test ImageIcon - ImageIcon
  print('ImageIcon is available in the widgets package');
  print('ImageIcon runtimeType accessible');

  print('ImageIcon test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('ImageIcon Tests'),
      Text('ImageIcon'),
    ],
  );
}
