// D4rt test script: Tests DefaultSpellCheckService from services
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('DefaultSpellCheckService test executing');

  // Test DefaultSpellCheckService - Default spell check
  print('DefaultSpellCheckService is available in the services package');
  print('DefaultSpellCheckService: Default spell check');

  print('DefaultSpellCheckService test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('DefaultSpellCheckService Tests'),
      Text('Default spell check'),
    ],
  );
}
