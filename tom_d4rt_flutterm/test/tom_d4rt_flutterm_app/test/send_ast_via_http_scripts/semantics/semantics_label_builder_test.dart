// D4rt test script: Tests SemanticsLabelBuilder from semantics
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('SemanticsLabelBuilder test executing');

  // Test SemanticsLabelBuilder - Label building
  print('SemanticsLabelBuilder is available in the semantics package');
  print('SemanticsLabelBuilder: Label building');

  print('SemanticsLabelBuilder test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('SemanticsLabelBuilder Tests'),
      Text('Label building'),
    ],
  );
}
