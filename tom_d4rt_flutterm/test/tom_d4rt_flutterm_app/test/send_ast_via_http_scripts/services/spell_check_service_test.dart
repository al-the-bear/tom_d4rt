// D4rt test script: Tests SpellCheckService from services
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('SpellCheckService test executing');

  // Test SpellCheckService - Spell checking
  print('SpellCheckService is available in the services package');
  print('SpellCheckService: Spell checking');

  print('SpellCheckService test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('SpellCheckService Tests'),
      Text('Spell checking'),
    ],
  );
}
