// D4rt test script: Tests MessageProperty from foundation
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('MessageProperty test executing');
  print('=' * 50);

  // Create basic MessageProperty
  final mp1 = MessageProperty('status', 'All systems operational');
  print('\nBasic MessageProperty:');
  print('runtimeType: ${mp1.runtimeType}');
  print('name: ${mp1.name}');
  print('value: ${mp1.value}');
  print('toString: ${mp1.toString()}');

  // Test inherited DiagnosticsProperty properties
  print('\nDiagnosticsProperty properties:');
  print('level: ${mp1.level}');
  print('showName: ${mp1.showName}');
  print('showSeparator: ${mp1.showSeparator}');
  print('style: ${mp1.style}');

  // Create with different diagnostic levels
  print('\nDifferent diagnostic levels:');
  final infoMsg = MessageProperty(
    'info',
    'Processing complete',
    level: DiagnosticLevel.info,
  );
  final warningMsg = MessageProperty(
    'warning',
    'Low memory',
    level: DiagnosticLevel.warning,
  );
  final errorMsg = MessageProperty(
    'error',
    'Connection failed',
    level: DiagnosticLevel.error,
  );
  print('info level: ${infoMsg.level}');
  print('warning level: ${warningMsg.level}');
  print('error level: ${errorMsg.level}');

  // Create with various message types
  print('\nVarious message types:');
  final shortMsg = MessageProperty('status', 'OK');
  final longMsg = MessageProperty(
    'description',
    'This is a very long message that provides detailed information about the current state of the application and what actions are being performed.',
  );
  final emptyMsg = MessageProperty('empty', '');
  print('Short: ${shortMsg.value}');
  print('Long length: ${longMsg.value.length}');
  print('Empty isEmpty: ${emptyMsg.value.isEmpty}');

  // Test string representations
  print('\nString representations:');
  print('mp1.toString(): ${mp1.toString()}');
  print('mp1.toDescription(): ${mp1.toDescription()}');

  // Test type hierarchy
  print('\nType hierarchy:');
  print('is DiagnosticsProperty: ${mp1 is DiagnosticsProperty}');
  print('is DiagnosticsNode: ${mp1 is DiagnosticsNode}');
  print('is Object: ${mp1 is Object}');

  // Compare with StringProperty
  print('\nComparison with StringProperty:');
  final stringProp = StringProperty('text', 'Hello');
  print('MessageProperty type: ${mp1.runtimeType}');
  print('StringProperty type: ${stringProp.runtimeType}');

  // Error message patterns
  print('\nCommon error patterns:');
  final renderError = MessageProperty(
    'RenderFlex',
    'Children have non-zero flex but incoming width constraints are unbounded.',
  );
  final asyncError = MessageProperty(
    'Future',
    'Unhandled exception in callback',
  );
  print('RenderFlex: ${renderError.value.substring(0, 40)}...');
  print('Future: ${asyncError.value}');

  // Explain purpose
  print('\nMessageProperty purpose:');
  print('- DiagnosticsProperty for displaying messages');
  print('- Used in FlutterError for error descriptions');
  print('- Supports diagnostic levels (info, warning, error)');
  print('- Shows message without additional value formatting');
  print('- Useful for human-readable diagnostic output');

  print('\n' + '=' * 50);
  print('MessageProperty test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'MessageProperty Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Type: ${mp1.runtimeType}'),
      Text('status: ${mp1.value}'),
      Text('error level: ${errorMsg.level}'),
      Text('is DiagnosticsProperty: ${mp1 is DiagnosticsProperty}'),
      Text('Purpose: Message display in diagnostics'),
    ],
  );
}
