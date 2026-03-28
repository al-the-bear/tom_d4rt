// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests RawChip from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('RawChip test executing');
  print('=' * 50);

  // RawChip is the base chip widget
  print('RawChip overview:');
  print('  - Base widget for all chip types');
  print('  - Implements multiple chip interfaces');
  print('  - Requires Material ancestor');

  // Test basic RawChip creation
  print('\nTest basic RawChip:');
  final chip1 = RawChip(
    label: Text('Basic Chip'),
  );
  print('  Created: ${chip1.runtimeType}');
  print('  Label: ${chip1.label}');
  print('  Selected: ${chip1.selected}');
  print('  Enabled: ${chip1.isEnabled}');
  print('  TapEnabled: ${chip1.tapEnabled}');

  // Test chip with avatar
  print('\nTest RawChip with avatar:');
  final chip2 = RawChip(
    avatar: CircleAvatar(child: Text('A')),
    label: Text('Avatar Chip'),
    selected: true,
  );
  print('  Has avatar: ${chip2.avatar != null}');
  print('  Selected: ${chip2.selected}');

  // Test deletable chip
  print('\nTest deletable RawChip:');
  final chip3 = RawChip(
    label: Text('Deletable'),
    onDeleted: () {},
    deleteButtonTooltipMessage: 'Remove',
  );
  print('  Has onDeleted: ${chip3.onDeleted != null}');
  print('  Delete tooltip: ${chip3.deleteButtonTooltipMessage}');

  // Test chip with onPressed
  print('\nTest tappable RawChip:');
  final chip4 = RawChip(
    label: Text('Tappable'),
    onPressed: () {},
    tooltip: 'Tap me',
  );
  print('  Has onPressed: ${chip4.onPressed != null}');
  print('  Tooltip: ${chip4.tooltip}');

  // Test chip styling
  print('\nTest RawChip styling:');
  final chip5 = RawChip(
    label: Text('Styled'),
    backgroundColor: Colors.blue,
    selectedColor: Colors.green,
    disabledColor: Colors.grey,
    elevation: 4.0,
    pressElevation: 8.0,
  );
  print('  BackgroundColor: ${chip5.backgroundColor}');
  print('  SelectedColor: ${chip5.selectedColor}');
  print('  Elevation: ${chip5.elevation}');
  print('  PressElevation: ${chip5.pressElevation}');

  // Test chip shape
  print('\nTest RawChip shape:');
  final chip6 = RawChip(
    label: Text('Shaped'),
    shape: StadiumBorder(),
    clipBehavior: Clip.antiAlias,
  );
  print('  Shape: ${chip6.shape}');
  print('  ClipBehavior: ${chip6.clipBehavior}');

  // Implemented interfaces
  print('\nImplemented interfaces:');
  print('  - ChipAttributes');
  print('  - DeletableChipAttributes');
  print('  - SelectableChipAttributes');
  print('  - CheckmarkableChipAttributes');
  print('  - DisabledChipAttributes');
  print('  - TappableChipAttributes');

  print('\n' + '=' * 50);
  print('RawChip test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('RawChip Tests', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      SizedBox(height: 8),
      Text('Type: StatefulWidget'),
      Text('Purpose: Base chip widget'),
      chip1,
    ],
  );
}
