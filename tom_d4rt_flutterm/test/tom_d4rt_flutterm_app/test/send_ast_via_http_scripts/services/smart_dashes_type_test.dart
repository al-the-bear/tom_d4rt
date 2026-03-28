// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests SmartDashesType from services
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('SmartDashesType test executing');
  print('=' * 50);

  // SmartDashesType enum overview
  print('SmartDashesType enum overview:');
  print('  - Controls smart dash replacement in text input');
  print('  - iOS/macOS feature');
  print('  - 2 values: disabled, enabled');

  // Enumerate all values
  print('\nSmartDashesType values:');
  for (final value in SmartDashesType.values) {
    print('  ${value.name}: index=${value.index}');
  }
  print('SmartDashesType has ${SmartDashesType.values.length} values');

  // Test disabled
  print('\nTest SmartDashesType.disabled:');
  final disabled = SmartDashesType.disabled;
  print('  Name: ${disabled.name}');
  print('  Index: ${disabled.index}');
  print('  Smart dashes are disabled');

  // Test enabled
  print('\nTest SmartDashesType.enabled:');
  final enabled = SmartDashesType.enabled;
  print('  Name: ${enabled.name}');
  print('  Index: ${enabled.index}');
  print('  Smart dashes are enabled');

  // First and last
  print('\nFirst and last:');
  print('  First: ${SmartDashesType.values.first}');
  print('  Last: ${SmartDashesType.values.last}');

  // Usage context
  print('\nUsage context:');
  print('  TextField.smartDashesType');
  print('  CupertinoTextField.smartDashesType');
  print('  EditableText.smartDashesType');

  // Platform behavior
  print('\nPlatform behavior:');
  print('  iOS: Converts -- to —');
  print('  macOS: Converts -- to —');
  print('  Other platforms: No effect');

  // Comparison
  print('\nComparison:');
  print('  disabled == disabled: ${SmartDashesType.disabled == SmartDashesType.disabled}');
  print('  disabled == enabled: ${SmartDashesType.disabled == SmartDashesType.enabled}');

  // Switch pattern
  print('\nSwitch pattern:');
  final mode = SmartDashesType.enabled;
  switch (mode) {
    case SmartDashesType.disabled:
      print('  Smart dashes disabled');
      break;
    case SmartDashesType.enabled:
      print('  Smart dashes enabled');
      break;
  }

  // Related enums
  print('\nRelated enums:');
  print('  SmartQuotesType: Similar for quotes');

  print('\n' + '=' * 50);
  print('SmartDashesType test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('SmartDashesType Tests', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      SizedBox(height: 8),
      Text('Type: Enum'),
      Text('Values: disabled, enabled'),
      Text('Purpose: Text input formatting'),
    ],
  );
}
