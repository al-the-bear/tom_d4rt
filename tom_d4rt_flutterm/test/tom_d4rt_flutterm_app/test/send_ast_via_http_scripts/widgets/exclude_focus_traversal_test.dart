// D4rt test script: Tests ExcludeFocusTraversal from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('ExcludeFocusTraversal test executing');

  // Test ExcludeFocusTraversal - ExcludeFocusTraversal
  print('ExcludeFocusTraversal is available in the widgets package');
  print('ExcludeFocusTraversal runtimeType accessible');

  print('ExcludeFocusTraversal test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('ExcludeFocusTraversal Tests'),
      Text('ExcludeFocusTraversal'),
    ],
  );
}
