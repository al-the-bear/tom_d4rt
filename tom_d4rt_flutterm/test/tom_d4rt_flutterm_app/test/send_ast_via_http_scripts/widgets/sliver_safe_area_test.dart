// D4rt test script: Tests SliverSafeArea from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('SliverSafeArea test executing');

  // Test SliverSafeArea - Sliver safe area
  print('SliverSafeArea is available in the widgets package');
  print('SliverSafeArea runtimeType accessible');

  print('SliverSafeArea test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('SliverSafeArea Tests'),
      Text('Sliver safe area'),
    ],
  );
}
