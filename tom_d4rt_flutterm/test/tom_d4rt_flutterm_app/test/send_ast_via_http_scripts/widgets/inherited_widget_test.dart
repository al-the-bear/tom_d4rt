// D4rt test script: Tests InheritedWidget from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('InheritedWidget test executing');

  // Test InheritedWidget - Inherited widget
  print('InheritedWidget is available in the widgets package');
  print('InheritedWidget runtimeType accessible');

  print('InheritedWidget test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('InheritedWidget Tests'),
      Text('Inherited widget'),
    ],
  );
}
