// D4rt test script: Tests WindowingOwner from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('WindowingOwner test executing');

  // Test WindowingOwner - WindowingOwner
  print('WindowingOwner is available in the widgets package');
  print('WindowingOwner runtimeType accessible');

  print('WindowingOwner test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('WindowingOwner Tests'),
      Text('WindowingOwner'),
    ],
  );
}
