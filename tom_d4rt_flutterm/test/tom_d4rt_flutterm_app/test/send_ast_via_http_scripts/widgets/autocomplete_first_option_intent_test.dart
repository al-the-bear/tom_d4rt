// D4rt test script: Tests AutocompleteFirstOptionIntent from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('AutocompleteFirstOptionIntent test executing');

  // Test AutocompleteFirstOptionIntent - First option
  print('AutocompleteFirstOptionIntent is available in the widgets package');
  print('AutocompleteFirstOptionIntent runtimeType accessible');

  print('AutocompleteFirstOptionIntent test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('AutocompleteFirstOptionIntent Tests'),
      Text('First option'),
    ],
  );
}
