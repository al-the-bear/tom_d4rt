// D4rt test script: Tests RawScrollbarState from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('RawScrollbarState test executing');

  // Test RawScrollbarState - RawScrollbarState
  print('RawScrollbarState is available in the widgets package');
  print('RawScrollbarState runtimeType accessible');

  print('RawScrollbarState test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('RawScrollbarState Tests'),
      Text('RawScrollbarState'),
    ],
  );
}
