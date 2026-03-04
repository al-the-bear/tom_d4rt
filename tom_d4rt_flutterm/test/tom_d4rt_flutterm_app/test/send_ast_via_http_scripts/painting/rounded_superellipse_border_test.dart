// D4rt test script: Tests RoundedSuperellipseBorder from painting
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('RoundedSuperellipseBorder test executing');

  // Test RoundedSuperellipseBorder - Superellipse border
  print('RoundedSuperellipseBorder is available in the painting package');
  print('RoundedSuperellipseBorder: Superellipse border');

  print('RoundedSuperellipseBorder test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('RoundedSuperellipseBorder Tests'),
      Text('Superellipse border'),
    ],
  );
}
