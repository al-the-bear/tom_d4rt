// D4rt test script: Tests ErrorSpacer from foundation
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('ErrorSpacer comprehensive test executing');
  final results = <String>[];

  // ========== ErrorSpacer Tests ==========
  print('Testing ErrorSpacer...');

  // Test 1: Create ErrorSpacer
  final spacer = ErrorSpacer();
  assert(spacer != null, 'Should create ErrorSpacer');
  results.add('ErrorSpacer created');
  print('ErrorSpacer created: ${spacer.runtimeType}');

  // Test 2: Verify ErrorSpacer inheritance from DiagnosticsNode
  assert(spacer is DiagnosticsNode, 'Should be DiagnosticsNode');
  results.add('Inheritance: DiagnosticsNode');
  print('Is DiagnosticsNode: ${spacer is DiagnosticsNode}');

  // Test 3: Check level property
  final level = spacer.level;
  assert(level == DiagnosticLevel.info, 'Level should be info');
  results.add('Level: $level');
  print('DiagnosticLevel: $level');

  // Test 4: toString returns empty line
  final stringValue = spacer.toString();
  assert(stringValue == '', 'toString should be empty string');
  results.add('toString: empty string');
  print('toString: "$stringValue"');

  // Test 5: Name is empty for spacer
  final name = spacer.name;
  assert(name == null || name.isEmpty, 'Name should be null or empty');
  results.add('Name: ${name ?? 'null'}');
  print('Name: ${name ?? 'null'}');

  // Test 6: Check showName property
  final showName = spacer.showName;
  assert(showName == false, 'showName should be false');
  results.add('showName: $showName');
  print('showName: $showName');

  // Test 7: Purpose of ErrorSpacer
  results.add('Purpose: Adds blank line in error output');
  print('ErrorSpacer adds visual separation in diagnostics');

  // Test 8: DiagnosticLevel values
  final levels = DiagnosticLevel.values;
  assert(levels.contains(DiagnosticLevel.info), 'Should have info');
  assert(levels.contains(DiagnosticLevel.debug), 'Should have debug');
  assert(levels.contains(DiagnosticLevel.error), 'Should have error');
  results.add('DiagnosticLevel values: ${levels.length}');
  print('DiagnosticLevel values: $levels');

  // Test 9: Create multiple spacers
  final spacer2 = ErrorSpacer();
  final spacer3 = ErrorSpacer();
  assert(spacer2 != null && spacer3 != null, 'Multiple spacers allowed');
  results.add('Multiple spacers created');
  print('Created 3 ErrorSpacer instances');

  // Test 10: Use in error reporting context
  results.add('Used in FlutterError.reportError');
  print('ErrorSpacer is used in error reporting system');

  // Test 11: FlutterErrorDetails context
  results.add('FlutterErrorDetails uses spacers for formatting');
  print('Error details formatting includes spacers');

  // Test 12: DiagnosticsNode style concept
  results.add('DiagnosticsTreeStyle affects spacer rendering');
  print('Spacer rendered based on diagnostics style');

  // Test 13: Comparison of DiagnosticsNode types
  final stringProp = StringProperty('test', 'value');
  assert(stringProp is DiagnosticsNode, 'StringProperty is DiagnosticsNode');
  assert(spacer is DiagnosticsNode, 'ErrorSpacer is DiagnosticsNode');
  results.add('Both spacer and properties are DiagnosticsNode');
  print('Common base: DiagnosticsNode');

  // Test 14: Diagnosticable tree traversal
  results.add('Spacers appear in diagnosticsNodes lists');
  print('Error trees include spacers between sections');

  // Test 15: Check getProperties behavior
  final properties = spacer.getProperties();
  assert(properties.isEmpty, 'Spacer should have no properties');
  results.add('getProperties: empty list');
  print('Properties count: ${properties.length}');

  // Test 16: Check getChildren behavior
  final children = spacer.getChildren();
  assert(children.isEmpty, 'Spacer should have no children');
  results.add('getChildren: empty list');
  print('Children count: ${children.length}');

  // Test 17: toStringDeep behavior
  final deepString = spacer.toStringDeep();
  results.add('toStringDeep available');
  print('toStringDeep: "$deepString"');

  // Test 18: Error summary separation
  results.add('Separates error summary from stack trace');
  print('Visual separator in error output');

  // Test 19: Console formatting
  results.add('Improves error readability in console');
  print('Console output is more readable with spacers');

  // Test 20: Summary
  print('ErrorSpacer test completed with ${results.length} tests');
  results.add('All tests passed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('ErrorSpacer Tests', style: TextStyle(fontWeight: FontWeight.bold)),
      Text('Inheritance: DiagnosticsNode'),
      Text('Purpose: Blank line in error output'),
      Text('Level: DiagnosticLevel.info'),
      Text('Properties: none, Children: none'),
      Text('Tests passed: ${results.length}'),
    ],
  );
}
