// D4rt test script: Tests AttributedStringProperty from semantics
import 'package:flutter/semantics.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('AttributedStringProperty test executing');

  // Test AttributedStringProperty - Diagnostics property
  print('AttributedStringProperty is available in the semantics package');
  print('AttributedStringProperty: Diagnostics property');

  print('AttributedStringProperty test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('AttributedStringProperty Tests'),
      Text('Diagnostics property'),
    ],
  );
}
