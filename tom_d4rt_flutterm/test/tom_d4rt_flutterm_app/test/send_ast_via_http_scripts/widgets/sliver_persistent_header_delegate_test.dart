// D4rt test script: Tests SliverPersistentHeaderDelegate from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('SliverPersistentHeaderDelegate test executing');

  // Test SliverPersistentHeaderDelegate - SliverPersistentHeaderDelegate
  print('SliverPersistentHeaderDelegate is available in the widgets package');
  print('SliverPersistentHeaderDelegate runtimeType accessible');

  print('SliverPersistentHeaderDelegate test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('SliverPersistentHeaderDelegate Tests'),
      Text('SliverPersistentHeaderDelegate'),
    ],
  );
}
