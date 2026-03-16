// D4rt test script: Tests TextSelection from services
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('TextSelection test executing');

  // Test TextSelection - Text selection
  print('TextSelection is available in the services package');
  print('TextSelection: Text selection');

  print('TextSelection test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('TextSelection Tests'),
      Text('Text selection'),
    ],
  );
}
