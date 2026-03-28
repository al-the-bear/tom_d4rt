// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests SmartQuotesType from services
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('SmartQuotesType test executing');
  print('=' * 50);

  // SmartQuotesType enum overview
  print('SmartQuotesType enum overview:');
  print('  - Controls smart quote replacement in text input');
  print('  - iOS/macOS feature');
  print('  - 2 values: disabled, enabled');

  // Enumerate all values
  print('\nSmartQuotesType values:');
  for (final value in SmartQuotesType.values) {
    print('  ${value.name}: index=${value.index}');
  }
  print('SmartQuotesType has ${SmartQuotesType.values.length} values');

  // Test disabled
  print('\nTest SmartQuotesType.disabled:');
  final disabled = SmartQuotesType.disabled;
  print('  Name: ${disabled.name}');
  print('  Index: ${disabled.index}');
  print('  Smart quotes are disabled');

  // Test enabled
  print('\nTest SmartQuotesType.enabled:');
  final enabled = SmartQuotesType.enabled;
  print('  Name: ${enabled.name}');
  print('  Index: ${enabled.index}');
  print('  Smart quotes are enabled');

  // First and last
  print('\nFirst and last:');
  print('  First: ${SmartQuotesType.values.first}');
  print('  Last: ${SmartQuotesType.values.last}');

  // Usage context
  print('\nUsage context:');
  print('  TextField.smartQuotesType');
  print('  CupertinoTextField.smartQuotesType');
  print('  EditableText.smartQuotesType');

  // Platform behavior
  print('\nPlatform behavior:');
  print('  iOS: Converts " to curly quotes');
  print('  macOS: Converts " to curly quotes');
  print('  Other platforms: No effect');

  // Comparison
  print('\nComparison:');
  print('  disabled == disabled: ${SmartQuotesType.disabled == SmartQuotesType.disabled}');
  print('  disabled == enabled: ${SmartQuotesType.disabled == SmartQuotesType.enabled}');

  // Switch pattern
  print('\nSwitch pattern:');
  final mode = SmartQuotesType.enabled;
  switch (mode) {
    case SmartQuotesType.disabled:
      print('  Smart quotes disabled');
      break;
    case SmartQuotesType.enabled:
      print('  Smart quotes enabled');
      break;
  }

  // Related enums
  print('\nRelated enums:');
  print('  SmartDashesType: Similar for dashes');

  print('\n' + '=' * 50);
  print('SmartQuotesType test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('SmartQuotesType Tests', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      SizedBox(height: 8),
      Text('Type: Enum'),
      Text('Values: disabled, enabled'),
      Text('Purpose: Text input formatting'),
    ],
  );
}
