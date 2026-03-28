// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests WidgetStateOutlinedBorder from widgets
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('WidgetStateOutlinedBorder test executing');
  print('=' * 50);

  // WidgetStateOutlinedBorder resolves border shape based on state
  print('WidgetStateOutlinedBorder overview:');
  print('  - Abstract class extending OutlinedBorder');
  print('  - Implements WidgetStateProperty<OutlinedBorder?>');
  print('  - Resolves border shape per state');

  // Test resolveWith factory
  print('\nTesting resolveWith factory:');
  final border = WidgetStateOutlinedBorder.resolveWith((states) {
    if (states.contains(WidgetState.pressed)) {
      return RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: const BorderSide(color: Colors.red, width: 2),
      );
    }
    if (states.contains(WidgetState.hovered)) {
      return RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: Colors.blue, width: 1.5),
      );
    }
    return RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
      side: const BorderSide(color: Colors.grey),
    );
  });
  print('  Created resolveWith border');

  // Resolve with empty states
  print('\nResolving with empty states:');
  final defaultBorder = border.resolve({});
  print('  Default: ${defaultBorder.runtimeType}');

  // Resolve with pressed
  print('\nResolving with pressed:');
  final pressedBorder = border.resolve({WidgetState.pressed});
  print('  Pressed: ${pressedBorder.runtimeType}');

  // Resolve with hovered
  print('\nResolving with hovered:');
  final hoveredBorder = border.resolve({WidgetState.hovered});
  print('  Hovered: ${hoveredBorder.runtimeType}');

  // Different border shapes
  print('\nDifferent OutlinedBorder shapes:');
  final shapes = WidgetStateOutlinedBorder.resolveWith((states) {
    if (states.contains(WidgetState.selected)) {
      return const CircleBorder(side: BorderSide(color: Colors.green));
    }
    if (states.contains(WidgetState.focused)) {
      return const StadiumBorder(side: BorderSide(color: Colors.purple));
    }
    return const RoundedRectangleBorder();
  });
  print('  Selected: CircleBorder');
  print('  Focused: StadiumBorder');
  print('  Default: RoundedRectangleBorder');

  final selected = shapes.resolve({WidgetState.selected});
  print('  Selected resolves: ${selected.runtimeType}');

  // OutlinedBorder properties
  print('\nOutlinedBorder inherited features:');
  print('  - side: BorderSide');
  print('  - copyWith: create modified copy');
  print('  - scale: scale border dimensions');
  print('  - getInnerPath/getOuterPath');

  print('\n' + '=' * 50);
  print('WidgetStateOutlinedBorder test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'WidgetStateOutlinedBorder Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Type: OutlinedBorder + WidgetStateProperty'),
      Text('Factory: resolveWith()'),
      Text('Shapes: RoundedRectangle, Circle, Stadium'),
    ],
  );
}
