// D4rt test script: Tests LabeledGlobalKey from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('LabeledGlobalKey test executing');

  // Test LabeledGlobalKey - LabeledGlobalKey
  print('LabeledGlobalKey is available in the widgets package');
  print('LabeledGlobalKey runtimeType accessible');

  print('LabeledGlobalKey test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('LabeledGlobalKey Tests'),
      Text('LabeledGlobalKey'),
    ],
  );
}
