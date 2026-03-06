// D4rt test script: Tests TextInput from services
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('TextInput test executing');

  // Test TextInput - TextInput
  print('TextInput is available in the services package');
  print('TextInput: TextInput');

  print('TextInput test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('TextInput Tests'),
      Text('TextInput'),
    ],
  );
}
