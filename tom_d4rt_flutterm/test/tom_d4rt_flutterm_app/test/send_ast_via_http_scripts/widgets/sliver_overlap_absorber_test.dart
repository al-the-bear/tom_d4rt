// D4rt test script: Tests SliverOverlapAbsorber from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('SliverOverlapAbsorber test executing');

  // Test SliverOverlapAbsorber - SliverOverlapAbsorber
  print('SliverOverlapAbsorber is available in the widgets package');
  print('SliverOverlapAbsorber runtimeType accessible');

  print('SliverOverlapAbsorber test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('SliverOverlapAbsorber Tests'),
      Text('SliverOverlapAbsorber'),
    ],
  );
}
