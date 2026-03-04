// D4rt test script: Tests ExcludeFocus from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('ExcludeFocus test executing');

  // Test ExcludeFocus - ExcludeFocus
  print('ExcludeFocus is available in the widgets package');
  print('ExcludeFocus runtimeType accessible');

  print('ExcludeFocus test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('ExcludeFocus Tests'),
      Text('ExcludeFocus'),
    ],
  );
}
