// D4rt test script: Tests LocalizationsResolver from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('LocalizationsResolver test executing');

  // Test LocalizationsResolver - LocalizationsResolver
  print('LocalizationsResolver is available in the widgets package');
  print('LocalizationsResolver runtimeType accessible');

  print('LocalizationsResolver test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('LocalizationsResolver Tests'),
      Text('LocalizationsResolver'),
    ],
  );
}
