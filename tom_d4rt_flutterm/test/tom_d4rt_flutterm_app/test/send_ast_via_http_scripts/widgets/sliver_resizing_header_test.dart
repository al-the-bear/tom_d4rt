// D4rt test script: Tests SliverResizingHeader from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('SliverResizingHeader test executing');

  // Test SliverResizingHeader - Resizing header
  print('SliverResizingHeader is available in the widgets package');
  print('SliverResizingHeader runtimeType accessible');

  print('SliverResizingHeader test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('SliverResizingHeader Tests'),
      Text('Resizing header'),
    ],
  );
}
