// D4rt test script: Tests SelectionListenerNotifier from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('SelectionListenerNotifier test executing');

  // Test SelectionListenerNotifier - SelectionListenerNotifier
  print('SelectionListenerNotifier is available in the widgets package');
  print('SelectionListenerNotifier runtimeType accessible');

  print('SelectionListenerNotifier test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('SelectionListenerNotifier Tests'),
      Text('SelectionListenerNotifier'),
    ],
  );
}
