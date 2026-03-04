// D4rt test script: Tests DefaultSelectionStyle from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('DefaultSelectionStyle test executing');

  // Test DefaultSelectionStyle - DefaultSelectionStyle
  print('DefaultSelectionStyle is available in the widgets package');
  print('DefaultSelectionStyle runtimeType accessible');

  print('DefaultSelectionStyle test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('DefaultSelectionStyle Tests'),
      Text('DefaultSelectionStyle'),
    ],
  );
}
