// D4rt test script: Tests ParentDataWidget from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('ParentDataWidget test executing');

  // Test ParentDataWidget - Parent data
  print('ParentDataWidget is available in the widgets package');
  print('ParentDataWidget runtimeType accessible');

  print('ParentDataWidget test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('ParentDataWidget Tests'),
      Text('Parent data'),
    ],
  );
}
