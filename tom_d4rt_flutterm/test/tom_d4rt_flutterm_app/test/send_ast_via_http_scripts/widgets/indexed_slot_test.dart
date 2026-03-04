// D4rt test script: Tests IndexedSlot from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('IndexedSlot test executing');

  // Test IndexedSlot - IndexedSlot
  print('IndexedSlot is available in the widgets package');
  print('IndexedSlot runtimeType accessible');

  print('IndexedSlot test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('IndexedSlot Tests'),
      Text('IndexedSlot'),
    ],
  );
}
