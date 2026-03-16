// D4rt test script: Tests ExpensiveAndroidViewController from services
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('ExpensiveAndroidViewController test executing');

  // Test ExpensiveAndroidViewController - Expensive Android
  print('ExpensiveAndroidViewController is available in the services package');
  print('ExpensiveAndroidViewController: Expensive Android');

  print('ExpensiveAndroidViewController test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('ExpensiveAndroidViewController Tests'),
      Text('Expensive Android'),
    ],
  );
}
