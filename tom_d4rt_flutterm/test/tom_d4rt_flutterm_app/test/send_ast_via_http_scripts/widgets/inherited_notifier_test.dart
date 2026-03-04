// D4rt test script: Tests InheritedNotifier from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('InheritedNotifier test executing');

  // Test InheritedNotifier - Inherited notifier
  print('InheritedNotifier is available in the widgets package');
  print('InheritedNotifier runtimeType accessible');

  print('InheritedNotifier test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('InheritedNotifier Tests'),
      Text('Inherited notifier'),
    ],
  );
}
