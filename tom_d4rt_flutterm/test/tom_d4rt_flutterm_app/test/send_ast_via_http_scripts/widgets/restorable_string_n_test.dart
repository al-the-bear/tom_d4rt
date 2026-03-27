// ignore_for_file: avoid_print, deprecated_member_use
// D4rt test script: Tests RestorableStringN from widgets
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('RestorableStringN test executing');
  print('=' * 50);

  // RestorableStringN stores nullable String
  print('RestorableStringN:');
  print('Purpose: Store and restore nullable String values');
  print('Extends: _RestorablePrimitiveValueN<String?>');
  print('');

  // Create with null default
  print('Creating with null default:');
  final nullProp = RestorableStringN(null);
  print('Created: RestorableStringN(null)');
  print('runtimeType: ${nullProp.runtimeType}');
  print('');

  // Create with String default
  print('Creating with String default:');
  final strProp = RestorableStringN('Hello');
  print('Created: RestorableStringN(\'Hello\')');
  print('');

  // Various string scenarios
  print('Testing various string values:');
  final empty = RestorableStringN('');
  print('Empty string: \'\'');

  final whitespace = RestorableStringN('   ');
  print('Whitespace: \'   \'');

  final unicode = RestorableStringN('Hello 🌍 世界');
  print('Unicode: \'Hello 🌍 世界\'');

  final multiline = RestorableStringN('Line1\nLine2');
  print('Multiline: \'Line1\\nLine2\'');
  print('');

  // Practical use cases
  print('Practical use cases:');
  print('  - Optional user input');
  print('  - Nullable search query');
  print('  - Cleared form field');
  print('');

  // Type hierarchy
  print('Type hierarchy:');
  print('RestorableStringN');
  print('  extends _RestorablePrimitiveValueN<String?>');
  print('    extends RestorableValue<String?>');
  print('');

  print('Type checks:');
  print('is RestorableProperty: ${nullProp is RestorableProperty}');
  print('is RestorableValue: ${nullProp is RestorableValue}');

  // Cleanup
  nullProp.dispose();
  strProp.dispose();
  empty.dispose();
  whitespace.dispose();
  unicode.dispose();
  multiline.dispose();

  print('\n' + '=' * 50);
  print('RestorableStringN test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'RestorableStringN Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Nullable String restoration'),
      Text('Supports Unicode, multiline'),
      Text('Direct primitive storage'),
    ],
  );
}
