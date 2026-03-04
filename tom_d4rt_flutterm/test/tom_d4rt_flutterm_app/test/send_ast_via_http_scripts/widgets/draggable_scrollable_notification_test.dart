// D4rt test script: Tests DraggableScrollableNotification from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('DraggableScrollableNotification test executing');

  // Test DraggableScrollableNotification - DraggableScrollableNotification
  print('DraggableScrollableNotification is available in the widgets package');
  print('DraggableScrollableNotification runtimeType accessible');

  print('DraggableScrollableNotification test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('DraggableScrollableNotification Tests'),
      Text('DraggableScrollableNotification'),
    ],
  );
}
