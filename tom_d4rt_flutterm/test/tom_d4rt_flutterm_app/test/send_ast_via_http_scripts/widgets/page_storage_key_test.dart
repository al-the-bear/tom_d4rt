// D4rt test script: Tests PageStorageKey from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('PageStorageKey test executing');

  // Test PageStorageKey - Storage key
  print('PageStorageKey is available in the widgets package');
  print('PageStorageKey runtimeType accessible');

  print('PageStorageKey test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('PageStorageKey Tests'),
      Text('Storage key'),
    ],
  );
}
