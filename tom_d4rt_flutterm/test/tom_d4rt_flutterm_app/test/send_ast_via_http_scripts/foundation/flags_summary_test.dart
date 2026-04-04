// ignore_for_file: avoid_print, deprecated_member_use
// D4rt test script: Tests FlagsSummary from foundation
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('FlagsSummary test executing');
  print('=' * 50);

  // FlagsSummary extends DiagnosticsProperty<Map<String, T?>>
  print('Testing FlagsSummary<T> class');

  // Create a FlagsSummary with some flags
  final flags = FlagsSummary<bool>(
    'testFlags',
    <String, bool?>{
      'enabled': true,
      'visible': true,
      'selected': false,
      'disabled': null,
    },
  );
  print('\nFlagsSummary created');
  print('runtimeType: ${flags.runtimeType}');
  print('name: ${flags.name}');
  print('value: ${flags.value}');

  // Test valueToString
  print('\nvalueToString() output:');
  print('  ${flags.valueToString()}');

  // Test level
  print('\nDiagnosticLevel: ${flags.level}');
  print('Level name: ${flags.level.name}');

  // Create empty flags
  final emptyFlags = FlagsSummary<String>(
    'emptyFlags',
    <String, String?>{},
  );
  print('\nEmpty FlagsSummary:');
  print('Value: ${emptyFlags.value}');
  print('Level: ${emptyFlags.level}');
  print('Level is hidden for empty: ${emptyFlags.level == DiagnosticLevel.hidden}');

  // Create flags with all null values
  final nullFlags = FlagsSummary<int>(
    'nullFlags',
    <String, int?>{'a': null, 'b': null},
    ifEmpty: 'no flags set',
  );
  print('\nAll-null FlagsSummary with ifEmpty:');
  print('valueToString: ${nullFlags.valueToString()}');

  // Create flags with mixed values
  final mixedFlags = FlagsSummary<int>(
    'mixedFlags',
    <String, int?>{
      'count': 5,
      'size': 100,
      'index': null,
      'position': 42,
    },
    showName: true,
    showSeparator: true,
    level: DiagnosticLevel.info,
  );
  print('\nMixed FlagsSummary:');
  print('Name: ${mixedFlags.name}');
  print('ShowName: ${mixedFlags.showName}');
  print('Level: ${mixedFlags.level}');
  print('Value entries: ${mixedFlags.value.length}');

  // Test DiagnosticsProperty inheritance
  print('\nDiagnosticsProperty inheritance:');
  print('is DiagnosticsProperty: ${flags is DiagnosticsProperty}');
  print('is DiagnosticsNode: ${flags is DiagnosticsNode}');

  // Test toJsonMap (basic call)
  final delegate = DiagnosticsSerializationDelegate();
  final json = flags.toJsonMap(delegate);
  print('\ntoJsonMap result:');
  print('Has name: ${json.containsKey("name")}');
  print('Has type: ${json.containsKey("type")}');

  // Test toString
  print('\ntoString() output:');
  print('  ${flags.toString()}');

  print('\n' + '=' * 50);
  print('FlagsSummary test completed');

  return SingleChildScrollView(child: Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('FlagsSummary Tests', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      SizedBox(height: 8),
      Text('Extends: DiagnosticsProperty<Map<String, T?>>'),
      Text('Summarizes flag presence/absence'),
      Text('Level hidden when empty'),
    ],
  ));
}
