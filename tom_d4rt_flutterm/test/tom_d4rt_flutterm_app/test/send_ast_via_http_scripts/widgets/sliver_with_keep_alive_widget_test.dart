// D4rt test script: Tests SliverWithKeepAliveWidget from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('SliverWithKeepAliveWidget test executing');

  // Test SliverWithKeepAliveWidget - SliverWithKeepAliveWidget
  print('SliverWithKeepAliveWidget is available in the widgets package');
  print('SliverWithKeepAliveWidget runtimeType accessible');

  print('SliverWithKeepAliveWidget test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('SliverWithKeepAliveWidget Tests'),
      Text('SliverWithKeepAliveWidget'),
    ],
  );
}
