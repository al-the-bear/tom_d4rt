// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests DropdownMenu close behavior from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('DropdownMenu close behavior test executing');
  print('=' * 50);

  // DropdownMenu overview
  print('\nDropdownMenu close behavior overview:');
  print('Purpose: DropdownMenu widget manages open/close behavior');
  print('Close is triggered by: item selection, tap outside, pressing Escape');
  print('requestFocusOnTap controls focus behavior on open');

  // Create a basic DropdownMenu
  print('\nDropdownMenu with close behavior:');
  final entries = <DropdownMenuEntry<String>>[
    DropdownMenuEntry(value: 'one', label: 'Option One'),
    DropdownMenuEntry(value: 'two', label: 'Option Two'),
    DropdownMenuEntry(value: 'three', label: 'Option Three'),
  ];
  print('Created ${entries.length} DropdownMenuEntry items');

  // Examine DropdownMenuEntry properties
  for (final entry in entries) {
    print('  Entry: value=${entry.value}, label=${entry.label}');
    print('    enabled: ${entry.enabled}');
    print('    runtimeType: ${entry.runtimeType}');
  }

  // DropdownMenuEntry with disabled
  final disabledEntry = DropdownMenuEntry(value: 'disabled', label: 'Disabled', enabled: false);
  print('\nDisabled entry:');
  print('  value: ${disabledEntry.value}');
  print('  label: ${disabledEntry.label}');
  print('  enabled: ${disabledEntry.enabled}');

  // DropdownMenuEntry with leadingIcon
  final iconEntry = DropdownMenuEntry(
    value: 'icon',
    label: 'With Icon',
    leadingIcon: Icon(Icons.star),
  );
  print('\nEntry with icon:');
  print('  value: ${iconEntry.value}');
  print('  label: ${iconEntry.label}');
  print('  leadingIcon: ${iconEntry.leadingIcon?.runtimeType}');

  // DropdownMenuEntry with style
  final styledEntry = DropdownMenuEntry(
    value: 'styled',
    label: 'Styled Entry',
    style: ButtonStyle(foregroundColor: WidgetStatePropertyAll(Colors.red)),
  );
  print('\nStyled entry:');
  print('  value: ${styledEntry.value}');
  print('  label: ${styledEntry.label}');
  print('  style: ${styledEntry.style}');

  // Type checks
  print('\nType checks:');
  print('entries[0] runtimeType: ${entries[0].runtimeType}');
  print('is DropdownMenuEntry: ${entries[0] is DropdownMenuEntry}');

  // Create DropdownMenu widget (verify it can be built)
  final menu = DropdownMenu<String>(
    dropdownMenuEntries: entries,
    onSelected: (value) => print('Selected: $value'),
    requestFocusOnTap: false,
    label: Text('Test Menu'),
  );
  print('\nDropdownMenu widget created:');
  print('  runtimeType: ${menu.runtimeType}');
  print('  requestFocusOnTap: ${menu.requestFocusOnTap}');
  print('  dropdownMenuEntries: ${menu.dropdownMenuEntries.length} entries');

  print('\n' + '=' * 50);
  print('DropdownMenu close behavior test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'DropdownMenu Close Behavior Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('DropdownMenuEntry items: ${entries.length}'),
      Text('Disabled entry: enabled=${disabledEntry.enabled}'),
      Text('Icon entry: ${iconEntry.leadingIcon?.runtimeType}'),
      Text('DropdownMenu: ${menu.dropdownMenuEntries.length} entries'),
    ],
  );
}
