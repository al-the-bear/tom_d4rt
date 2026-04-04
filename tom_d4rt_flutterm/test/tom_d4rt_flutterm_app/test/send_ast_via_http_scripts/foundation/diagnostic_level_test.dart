// ignore_for_file: avoid_print, deprecated_member_use
// D4rt test script: Tests DiagnosticLevel from foundation
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('DiagnosticLevel test executing');
  print('=' * 50);

  // DiagnosticLevel is an enum with 9 values
  print('DiagnosticLevel enum values:');
  for (final level in DiagnosticLevel.values) {
    print('  ${level.name}: index=${level.index}');
  }
  print('DiagnosticLevel has ${DiagnosticLevel.values.length} values');

  // Test first and last
  final first = DiagnosticLevel.values.first;
  final last = DiagnosticLevel.values.last;
  print('\nFirst value: $first (index ${first.index})');
  print('Last value: $last (index ${last.index})');

  // Test each value individually
  print('\nTesting DiagnosticLevel.hidden:');
  final hidden = DiagnosticLevel.hidden;
  print('  name: ${hidden.name}');
  print('  index: ${hidden.index}');
  print('  toString: $hidden');

  print('\nTesting DiagnosticLevel.fine:');
  final fine = DiagnosticLevel.fine;
  print('  name: ${fine.name}');
  print('  index: ${fine.index}');
  print('  Purpose: Low-value diagnostics matching defaults');

  print('\nTesting DiagnosticLevel.debug:');
  final debug = DiagnosticLevel.debug;
  print('  name: ${debug.name}');
  print('  index: ${debug.index}');
  print('  Purpose: Fine-grained debugging info');

  print('\nTesting DiagnosticLevel.info:');
  final info = DiagnosticLevel.info;
  print('  name: ${info.name}');
  print('  index: ${info.index}');
  print('  Purpose: Interesting diagnostic to show');

  print('\nTesting DiagnosticLevel.warning:');
  final warning = DiagnosticLevel.warning;
  print('  name: ${warning.name}');
  print('  index: ${warning.index}');
  print('  Purpose: Problematic property values');

  print('\nTesting DiagnosticLevel.hint:');
  final hint = DiagnosticLevel.hint;
  print('  name: ${hint.name}');
  print('  index: ${hint.index}');
  print('  Purpose: Best practice hints');

  print('\nTesting DiagnosticLevel.summary:');
  final summary = DiagnosticLevel.summary;
  print('  name: ${summary.name}');
  print('  index: ${summary.index}');
  print('  Purpose: Summarizes other diagnostics');

  print('\nTesting DiagnosticLevel.error:');
  final error = DiagnosticLevel.error;
  print('  name: ${error.name}');
  print('  index: ${error.index}');
  print('  Purpose: Errors or unexpected conditions');

  print('\nTesting DiagnosticLevel.off:');
  final off = DiagnosticLevel.off;
  print('  name: ${off.name}');
  print('  index: ${off.index}');
  print('  Purpose: Filter level to show nothing');

  // Test equality
  print('\nEquality tests:');
  print('DiagnosticLevel.info == DiagnosticLevel.info: ${DiagnosticLevel.info == DiagnosticLevel.info}');
  print('DiagnosticLevel.info == DiagnosticLevel.debug: ${DiagnosticLevel.info == DiagnosticLevel.debug}');

  // Test comparison
  print('\nIndex comparison for severity:');
  print('error.index > warning.index: ${error.index > warning.index}');
  print('warning.index > info.index: ${warning.index > info.index}');

  print('\n' + '=' * 50);
  print('DiagnosticLevel test completed');

  return SingleChildScrollView(child: Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('DiagnosticLevel Tests', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      SizedBox(height: 8),
      Text('Values: ${DiagnosticLevel.values.length}'),
      Text('hidden, fine, debug, info'),
      Text('warning, hint, summary, error, off'),
    ],
  ));
}
