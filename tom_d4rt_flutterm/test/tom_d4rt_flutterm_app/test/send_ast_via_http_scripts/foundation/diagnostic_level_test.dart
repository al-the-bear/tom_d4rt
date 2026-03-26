// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests DiagnosticLevel from foundation
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('DiagnosticLevel test executing');
  print('=' * 50);

  // Enumerate all values
  print('\nDiagnosticLevel values:');
  for (final value in DiagnosticLevel.values) {
    print('  ${value.name}: index=${value.index}');
  }
  print('DiagnosticLevel has ${DiagnosticLevel.values.length} values');

  // First and last
  final first = DiagnosticLevel.values.first;
  final last = DiagnosticLevel.values.last;
  print('\nFirst: $first (${first.name}, index ${first.index})');
  print('Last: $last (${last.name}, index ${last.index})');

  // Each level individually
  print('\nSpecific levels:');
  print('hidden: ${DiagnosticLevel.hidden.name} (index ${DiagnosticLevel.hidden.index})');
  print('fine: ${DiagnosticLevel.fine.name} (index ${DiagnosticLevel.fine.index})');
  print('debug: ${DiagnosticLevel.debug.name} (index ${DiagnosticLevel.debug.index})');
  print('info: ${DiagnosticLevel.info.name} (index ${DiagnosticLevel.info.index})');
  print('warning: ${DiagnosticLevel.warning.name} (index ${DiagnosticLevel.warning.index})');
  print('hint: ${DiagnosticLevel.hint.name} (index ${DiagnosticLevel.hint.index})');
  print('summary: ${DiagnosticLevel.summary.name} (index ${DiagnosticLevel.summary.index})');
  print('error: ${DiagnosticLevel.error.name} (index ${DiagnosticLevel.error.index})');
  print('off: ${DiagnosticLevel.off.name} (index ${DiagnosticLevel.off.index})');

  // Equality
  print('\nEquality tests:');
  print('hidden == hidden: ${DiagnosticLevel.hidden == DiagnosticLevel.hidden}');
  print('hidden == fine: ${DiagnosticLevel.hidden == DiagnosticLevel.fine}');
  print('identical: ${identical(DiagnosticLevel.info, DiagnosticLevel.values[3])}');

  // Type checks
  print('\nType checks:');
  print('runtimeType: ${first.runtimeType}');
  print('is DiagnosticLevel: ${first is DiagnosticLevel}');
  print('is Enum: ${first is Enum}');

  // Ordering by severity
  print('\nOrdering (by severity):');
  final sorted = List<DiagnosticLevel>.from(DiagnosticLevel.values)
    ..sort((a, b) => a.index.compareTo(b.index));
  for (final v in sorted) {
    print('  ${v.index}: ${v.name}');
  }

  // Usage context
  print('\nUsage context:');
  print('hidden and fine: filtered by default in toString output');
  print('debug: development-time diagnostics');
  print('info: general information');
  print('warning: potential issues');
  print('hint: diagnostic hints for developers');
  print('summary: summary-level diagnostics');
  print('error: errors requiring attention');
  print('off: suppresses all diagnostics');

  // String representations
  print('\nString representations:');
  for (final value in DiagnosticLevel.values) {
    print('  $value => name: ${value.name}');
  }

  print('\n' + '=' * 50);
  print('DiagnosticLevel test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'DiagnosticLevel Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Values: ${DiagnosticLevel.values.length}'),
      for (final v in DiagnosticLevel.values) Text('  ${v.name} (${v.index})'),
    ],
  );
}
