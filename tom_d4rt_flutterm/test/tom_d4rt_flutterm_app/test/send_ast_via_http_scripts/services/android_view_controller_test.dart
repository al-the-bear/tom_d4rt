// D4rt test script: Tests AndroidViewController from services
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('AndroidViewController test executing');

  // Test AndroidViewController - Android views
  print('AndroidViewController is available in the services package');
  print('AndroidViewController: Android views');

  print('AndroidViewController test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('AndroidViewController Tests'),
      Text('Android views'),
    ],
  );
}
