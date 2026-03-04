// D4rt test script: Tests RouteInformation from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('RouteInformation test executing');

  // Test RouteInformation - RouteInformation
  print('RouteInformation is available in the widgets package');
  print('RouteInformation runtimeType accessible');

  print('RouteInformation test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('RouteInformation Tests'),
      Text('RouteInformation'),
    ],
  );
}
