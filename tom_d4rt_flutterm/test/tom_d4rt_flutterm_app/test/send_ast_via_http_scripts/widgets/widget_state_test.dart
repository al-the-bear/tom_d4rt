// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests WidgetState enum from widgets
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('WidgetState test executing');
  print('=' * 50);

  // WidgetState enum for interactive states
  print('WidgetState enum overview:');
  print('  - Enum with standard interactive states');
  print('  - Implements WidgetStatesConstraint');
  print('  - Used by WidgetStateProperty classes');

  // All enum values
  print('\nAll WidgetState values:');
  for (final state in WidgetState.values) {
    print('  - ${state.name}');
  }
  print('  Total: ${WidgetState.values.length} states');

  // Test individual states
  print('\nTesting individual states:');
  print('  hovered: ${WidgetState.hovered}');
  print('  focused: ${WidgetState.focused}');
  print('  pressed: ${WidgetState.pressed}');
  print('  dragged: ${WidgetState.dragged}');
  print('  selected: ${WidgetState.selected}');
  print('  scrolledUnder: ${WidgetState.scrolledUnder}');
  print('  disabled: ${WidgetState.disabled}');
  print('  error: ${WidgetState.error}');

  // isSatisfiedBy method
  print('\nTesting isSatisfiedBy:');
  final states = {WidgetState.hovered, WidgetState.focused};
  print('  State set: $states');
  print('  hovered.isSatisfiedBy: ${WidgetState.hovered.isSatisfiedBy(states)}');
  print('  focused.isSatisfiedBy: ${WidgetState.focused.isSatisfiedBy(states)}');
  print('  pressed.isSatisfiedBy: ${WidgetState.pressed.isSatisfiedBy(states)}');

  // WidgetState.any
  print('\nWidgetState.any constraint:');
  print('  - Matches any set of states');
  print('  - Use as fallback in WidgetStateMap');
  final anyConstraint = WidgetState.any;
  print('  any.isSatisfiedBy(empty): ${anyConstraint.isSatisfiedBy({})}');
  print('  any.isSatisfiedBy(states): ${anyConstraint.isSatisfiedBy(states)}');

  // Creating state sets
  print('\nCreating state sets:');
  final hoveredOnly = {WidgetState.hovered};
  final multiple = {WidgetState.hovered, WidgetState.pressed, WidgetState.focused};
  print('  Single state: $hoveredOnly');
  print('  Multiple states: $multiple');
  print('  Contains hovered: ${multiple.contains(WidgetState.hovered)}');

  // Usage with WidgetStateProperty
  print('\nUsage with WidgetStateProperty:');
  print('  WidgetStateProperty.resolveWith((states) {');
  print('    if (states.contains(WidgetState.disabled)) return ...');
  print('    if (states.contains(WidgetState.pressed)) return ...');
  print('  })');

  print('\n' + '=' * 50);
  print('WidgetState test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'WidgetState Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Type: enum'),
      Text('Values: hovered, focused, pressed, dragged, ...'),
      Text('Static: WidgetState.any'),
    ],
  );
}
