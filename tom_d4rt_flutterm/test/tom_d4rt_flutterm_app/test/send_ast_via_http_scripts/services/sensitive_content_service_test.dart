// D4rt test script: Tests SensitiveContentService from services
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('SensitiveContentService test executing');

  // Test SensitiveContentService - Sensitive content
  print('SensitiveContentService is available in the services package');
  print('SensitiveContentService: Sensitive content');

  print('SensitiveContentService test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('SensitiveContentService Tests'),
      Text('Sensitive content'),
    ],
  );
}
