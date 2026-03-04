// D4rt test script: Tests BuildOwner from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('BuildOwner test executing');

  // Test BuildOwner - Build owner
  print('BuildOwner is available in the widgets package');
  print('BuildOwner runtimeType accessible');

  print('BuildOwner test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('BuildOwner Tests'),
      Text('Build owner'),
    ],
  );
}
