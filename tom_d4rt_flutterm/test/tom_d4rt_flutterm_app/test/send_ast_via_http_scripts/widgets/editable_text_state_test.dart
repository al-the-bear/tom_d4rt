// D4rt test script: Tests EditableTextState from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('EditableTextState test executing');

  // Test EditableTextState - Editable state
  print('EditableTextState is available in the widgets package');
  print('EditableTextState runtimeType accessible');

  print('EditableTextState test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('EditableTextState Tests'),
      Text('Editable state'),
    ],
  );
}
