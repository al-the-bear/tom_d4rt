// D4rt test script: Tests ErrorSpacer from foundation
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('ErrorSpacer test executing');

  // Create ErrorSpacer instance
  final spacer = ErrorSpacer();
  print('ErrorSpacer created: ${spacer.runtimeType}');

  // Test inherited DiagnosticsNode properties
  print('\nDiagnosticsNode properties:');
  print('level: ${spacer.level}');
  print('name: ${spacer.name}');
  print('showName: ${spacer.showName}');
  print('showSeparator: ${spacer.showSeparator}');
  print('emptyBodyDescription: ${spacer.emptyBodyDescription}');

  // Test string representations
  print('\nString representations:');
  print('toString(): "${spacer.toString()}"');
  print('toDescription(): "${spacer.toDescription()}"');

  // Test style
  print('\nStyling:');
  print('style: ${spacer.style}');

  // Test allowTruncate
  print('\nTruncation:');
  print('allowTruncate: ${spacer.allowTruncate}');

  // Test value
  final value = spacer.value;
  print('\nValue:');
  print('value: $value');
  print('value type: ${value?.runtimeType ?? "null"}');

  // Explain purpose
  print('\nErrorSpacer purpose:');
  print('- Creates blank line in error output');
  print('- Used to separate sections in FlutterError');
  print('- Improves readability of diagnostic output');
  print('- Part of diagnostics tree hierarchy');

  print('\nErrorSpacer test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'ErrorSpacer Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Type: ${spacer.runtimeType}'),
      Text('level: ${spacer.level}'),
      Text('name: ${spacer.name ?? "(none)"}'),
      Text('showName: ${spacer.showName}'),
      Text('Purpose: Blank line separator in errors'),
    ],
  );
}
