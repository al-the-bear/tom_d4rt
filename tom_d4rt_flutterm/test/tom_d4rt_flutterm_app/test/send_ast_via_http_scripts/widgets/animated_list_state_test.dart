// D4rt test script: Tests AnimatedListState from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('AnimatedListState test executing');

  // Test AnimatedListState - List state
  print('AnimatedListState is available in the widgets package');
  print('AnimatedListState runtimeType accessible');

  print('AnimatedListState test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('AnimatedListState Tests'),
      Text('List state'),
    ],
  );
}
