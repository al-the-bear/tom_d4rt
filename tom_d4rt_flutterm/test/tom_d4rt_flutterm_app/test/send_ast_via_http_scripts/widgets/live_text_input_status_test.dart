// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests LiveTextInputStatus from widgets
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('LiveTextInputStatus test executing');
  print('=' * 50);

  // === Test LiveTextInputStatus enum ===
  print('\nLiveTextInputStatus indicates Live Text input availability');

  // Enumerate all values
  print('\nLiveTextInputStatus values:');
  for (final value in LiveTextInputStatus.values) {
    print('  ${value.name}: index=${value.index}');
  }
  print('LiveTextInputStatus has ${LiveTextInputStatus.values.length} values');

  // Test each value
  print('\n--- Testing LiveTextInputStatus.enabled ---');
  final enabled = LiveTextInputStatus.enabled;
  print('enabled: $enabled');
  print('enabled.index: ${enabled.index}');
  print('enabled.name: ${enabled.name}');
  print('Meaning: Device supports Live Text input');

  print('\n--- Testing LiveTextInputStatus.unknown ---');
  final unknown = LiveTextInputStatus.unknown;
  print('unknown: $unknown');
  print('unknown.index: ${unknown.index}');
  print('unknown.name: ${unknown.name}');
  print('Meaning: Status not yet determined (async check pending)');

  print('\n--- Testing LiveTextInputStatus.disabled ---');
  final disabled = LiveTextInputStatus.disabled;
  print('disabled: $disabled');
  print('disabled.index: ${disabled.index}');
  print('disabled.name: ${disabled.name}');
  print('Meaning: Device does not support Live Text input');

  // Test comparisons
  print('\n--- Testing comparisons ---');
  print('enabled == enabled: ${enabled == LiveTextInputStatus.enabled}');
  print('enabled == disabled: ${enabled == disabled}');
  print('unknown != enabled: ${unknown != enabled}');

  // Test first and last
  print('\n--- Testing first and last ---');
  final first = LiveTextInputStatus.values.first;
  final last = LiveTextInputStatus.values.last;
  print('First value: $first (index ${first.index})');
  print('Last value: $last (index ${last.index})');

  // Test hashCode
  print('\n--- Testing hashCode ---');
  print('enabled.hashCode: ${enabled.hashCode}');
  print('unknown.hashCode: ${unknown.hashCode}');
  print('disabled.hashCode: ${disabled.hashCode}');

  // Test usage context
  print('\n--- Usage context ---');
  print('Used with LiveTextInputStatusNotifier');
  print('Tracks iOS Live Text (OCR) capability');
  print('Unknown is initial state before async check');

  print('\n' + '=' * 50);
  print('LiveTextInputStatus test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'LiveTextInputStatus Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Values: ${LiveTextInputStatus.values.length}'),
      Text('enabled: ${LiveTextInputStatus.enabled.index}'),
      Text('unknown: ${LiveTextInputStatus.unknown.index}'),
      Text('disabled: ${LiveTextInputStatus.disabled.index}'),
    ],
  );
}
