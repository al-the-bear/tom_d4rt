// ignore_for_file: avoid_print, deprecated_member_use
// D4rt test script: Tests RestorableString from widgets
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('RestorableString test executing');
  print('=' * 50);

  // RestorableString stores non-null String
  print('RestorableString:');
  print('Purpose: Store and restore non-null String values');
  print('Extends: _RestorablePrimitiveValue<String>');
  print('');

  // Create with default value
  print('Creating with default value:');
  final prop = RestorableString('Default');
  print('Created: RestorableString(\'Default\')');
  print('runtimeType: ${prop.runtimeType}');
  print('');

  // Various string tests
  print('Testing various string values:');
  final empty = RestorableString('');
  print('Empty string is valid');

  final greeting = RestorableString('Hello, World!');
  print('Greeting: \'Hello, World!\'');

  final unicode = RestorableString('日本語 テスト');
  print('Unicode: \'日本語 テスト\'');

  final special = RestorableString('Tab:\tNewline:\n');
  print('Special chars: \'Tab:\\tNewline:\\n\'');
  print('');

  // Practical examples
  print('Practical use cases:');
  print('  - User name');
  print('  - Form field text');
  print('  - Search query');
  print('  - App preferences');
  print('');

  // Serialization
  print('Serialization:');
  print('  Direct string storage');
  print('  No conversion needed');
  print('  Preserves all characters');
  print('');

  // Type hierarchy
  print('Type hierarchy:');
  print('RestorableString');
  print('  extends _RestorablePrimitiveValue<String>');
  print('    extends _RestorablePrimitiveValueN<String>');
  print('      extends RestorableValue<String>');
  print('');

  print('Type checks:');
  print('is RestorableProperty: ${prop is RestorableProperty}');
  print('is RestorableValue: ${prop is RestorableValue}');

  // Cleanup
  prop.dispose();
  empty.dispose();
  greeting.dispose();
  unicode.dispose();
  special.dispose();

  print('\n' + '=' * 50);
  print('RestorableString test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'RestorableString Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Non-null String restoration'),
      Text('Full Unicode support'),
      Text('Direct primitive storage'),
    ],
  );
}
