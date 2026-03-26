// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests FlagsSummary from foundation
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('FlagsSummary test executing');
  print('=' * 50);

  // FlagsSummary overview
  print('\nFlagsSummary overview:');
  print('Purpose: DiagnosticsProperty for displaying a map of boolean flags');
  print('Extends: DiagnosticsProperty<Map<String, T?>>');
  print('Usage: Show which flags are set in diagnostics output');

  // Create FlagsSummary with bool flags
  final flags1 = FlagsSummary<bool>(
    'testFlags',
    {'enabled': true, 'visible': false, 'active': true, 'selected': null},
    ifEmpty: 'no flags set',
  );
  print('\nFlagsSummary<bool> created:');
  print('name: ${flags1.name}');
  print('value: ${flags1.value}');
  print('runtimeType: ${flags1.runtimeType}');
  print('is DiagnosticsProperty: ${flags1 is DiagnosticsProperty}');
  print('is DiagnosticsNode: ${flags1 is DiagnosticsNode}');
  print('level: ${flags1.level}');
  print('toString: ${flags1.toString()}');
  print('toDescription: ${flags1.toDescription()}');

  // FlagsSummary with String values
  final flags2 = FlagsSummary<String>(
    'textFlags',
    {'label': 'Hello', 'hint': null, 'value': 'World'},
    ifEmpty: 'none',
  );
  print('\nFlagsSummary<String> created:');
  print('name: ${flags2.name}');
  print('value: ${flags2.value}');
  print('toDescription: ${flags2.toDescription()}');

  // FlagsSummary with all null values
  final emptyFlags = FlagsSummary<bool>(
    'emptyFlags',
    {'a': null, 'b': null, 'c': null},
    ifEmpty: 'all flags are null',
  );
  print('\nEmpty FlagsSummary:');
  print('toDescription: ${emptyFlags.toDescription()}');

  // FlagsSummary with all set
  final allSet = FlagsSummary<bool>(
    'allFlags',
    {'flag1': true, 'flag2': true, 'flag3': true},
  );
  print('\nAll flags set:');
  print('toDescription: ${allSet.toDescription()}');

  // Diagnostic levels
  final warningFlags = FlagsSummary<bool>(
    'warningFlags',
    {'warning': true},
    level: DiagnosticLevel.warning,
  );
  print('\nWarning level flags:');
  print('level: ${warningFlags.level}');
  print('name: ${warningFlags.name}');

  // Type hierarchy
  print('\nType hierarchy:');
  print('is DiagnosticsProperty: ${flags1 is DiagnosticsProperty}');
  print('is DiagnosticsNode: ${flags1 is DiagnosticsNode}');

  // Property features
  print('\nProperty features:');
  print('showName: ${flags1.showName}');
  print('showSeparator: ${flags1.showSeparator}');
  print('isFiltered: ${flags1.isFiltered(DiagnosticLevel.info)}');

  print('\n' + '=' * 50);
  print('FlagsSummary test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'FlagsSummary Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Bool flags: ${flags1.toDescription()}'),
      Text('String flags: ${flags2.toDescription()}'),
      Text('Empty flags: ${emptyFlags.toDescription()}'),
      Text('All set: ${allSet.toDescription()}'),
      Text('Type: DiagnosticsProperty subclass'),
    ],
  );
}
