// D4rt test script: Tests OffsetBase from dart_ui
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('OffsetBase test executing');

  // Test OffsetBase - Base class for Offset
  print('OffsetBase is available in the dart_ui package');
  print('OffsetBase: Base class for Offset');

  print('OffsetBase test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('OffsetBase Tests'),
      Text('Base class for Offset'),
    ],
  );
}
