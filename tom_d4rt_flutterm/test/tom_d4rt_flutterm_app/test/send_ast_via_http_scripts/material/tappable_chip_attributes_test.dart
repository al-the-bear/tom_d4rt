// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests TappableChipAttributes from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('TappableChipAttributes test executing');
  print('=' * 50);

  // TappableChipAttributes overview
  print('TappableChipAttributes overview:');
  print('  - Abstract interface for chips');
  print('  - Defines tap-related properties');
  print('  - Implemented by RawChip');

  // Interface properties
  print('\nInterface properties:');
  print('  VoidCallback? onPressed');
  print('  double? pressElevation');
  print('  String? tooltip');

  // Test via RawChip (implements interface)
  print('\nTest via RawChip (implements interface):');
  final chip1 = RawChip(
    label: Text('Tappable'),
    onPressed: () {},
    pressElevation: 8.0,
    tooltip: 'Tap to activate',
  );
  print('  onPressed: ${chip1.onPressed}');
  print('  pressElevation: ${chip1.pressElevation}');
  print('  tooltip: ${chip1.tooltip}');

  // Test disabled chip (no onPressed)
  print('\nTest disabled chip:');
  final chip2 = RawChip(
    label: Text('Disabled'),
    onPressed: null,
    tooltip: 'Disabled chip',
  );
  print('  onPressed: ${chip2.onPressed}');
  print('  Disabled: ${chip2.onPressed == null}');

  // Test elevation behavior
  print('\nElevation behavior:');
  print('  Default elevation: from ChipTheme');
  print('  Press elevation: applied on press');
  print('  Values must be >= 0');

  // Chips implementing interface
  print('\nChips implementing TappableChipAttributes:');
  print('  - RawChip');
  print('  - InputChip');
  print('  - ChoiceChip');
  print('  - FilterChip');
  print('  - ActionChip');

  // Related interfaces
  print('\nRelated chip interfaces:');
  print('  - ChipAttributes (base)');
  print('  - DeletableChipAttributes');
  print('  - SelectableChipAttributes');
  print('  - CheckmarkableChipAttributes');
  print('  - DisabledChipAttributes');

  // Usage pattern
  print('\nUsage pattern:');
  print('  ActionChip(');
  print('    label: Text("Action"),');
  print('    onPressed: () => doAction(),');
  print('    tooltip: "Perform action",');
  print('  )');

  // Accessibility
  print('\nAccessibility:');
  print('  - tooltip shown on hover/long-press');
  print('  - Semantic button action');
  print('  - Focus management');

  print('\n' + '=' * 50);
  print('TappableChipAttributes test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('TappableChipAttributes Tests', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      SizedBox(height: 8),
      Text('Type: Abstract interface'),
      Text('Purpose: Chip tap properties'),
      chip1,
    ],
  );
}
