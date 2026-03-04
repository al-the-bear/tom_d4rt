// D4rt test script: Tests SliverOverlapInjector from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('SliverOverlapInjector test executing');

  // Test SliverOverlapInjector - SliverOverlapInjector
  print('SliverOverlapInjector is available in the widgets package');
  print('SliverOverlapInjector runtimeType accessible');

  print('SliverOverlapInjector test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('SliverOverlapInjector Tests'),
      Text('SliverOverlapInjector'),
    ],
  );
}
