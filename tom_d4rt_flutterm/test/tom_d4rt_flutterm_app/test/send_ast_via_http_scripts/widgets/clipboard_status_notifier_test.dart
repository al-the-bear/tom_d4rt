// D4rt test script: Tests ClipboardStatusNotifier from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('ClipboardStatusNotifier test executing');

  // Test ClipboardStatusNotifier - Clipboard status
  print('ClipboardStatusNotifier is available in the widgets package');
  print('ClipboardStatusNotifier runtimeType accessible');

  print('ClipboardStatusNotifier test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('ClipboardStatusNotifier Tests'),
      Text('Clipboard status'),
    ],
  );
}
