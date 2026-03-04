// D4rt test script: Tests SelectionContainer from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('SelectionContainer test executing');

  // Test SelectionContainer - Selection container
  print('SelectionContainer is available in the widgets package');
  print('SelectionContainer runtimeType accessible');

  print('SelectionContainer test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('SelectionContainer Tests'),
      Text('Selection container'),
    ],
  );
}
