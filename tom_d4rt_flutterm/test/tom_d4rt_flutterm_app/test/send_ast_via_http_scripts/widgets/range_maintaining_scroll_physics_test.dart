// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests RangeMaintainingScrollPhysics from widgets
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('RangeMaintainingScrollPhysics test executing');
  print('=' * 50);

  // === Test RangeMaintainingScrollPhysics ===
  print('\nRangeMaintainingScrollPhysics maintains scroll position');

  // Create physics
  print('\n--- Creating physics ---');
  const physics = RangeMaintainingScrollPhysics();
  print('Created RangeMaintainingScrollPhysics()');
  print('physics.runtimeType: ${physics.runtimeType}');

  // Test inheritance
  print('\n--- Inheritance ---');
  print('physics is ScrollPhysics: ${physics is ScrollPhysics}');
  print('Extends ScrollPhysics');

  // applyTo method
  print('\n--- applyTo() method ---');
  final withParent = physics.applyTo(const BouncingScrollPhysics());
  print('applyTo(BouncingScrollPhysics)');
  print('Result type: ${withParent.runtimeType}');

  // Key method
  print('\n--- adjustPositionForNewDimensions() ---');
  print('Called when scroll dimensions change');
  print('Maintains position relative to boundaries');
  print('Handles content add/remove gracefully');

  // Position adjustment rules
  print('\n--- Position adjustment rules ---');
  print('1. If animating: no adjustment');
  print('2. If extents unchanged: ignore overscroll');
  print('3. If position already changed: defer');
  print('4. If was out of range: no enforcement');

  // Overscroll maintenance
  print('\n--- Overscroll maintenance ---');
  print('If was overscrolled above min:');
  print('  Calculate delta from old boundary');
  print('  Apply delta to new boundary');
  print('Same logic for max overscroll');

  // Use case
  print('\n--- When to use ---');
  print('Dynamic content (add/remove items)');
  print('Keep scroll position stable');
  print('Prevent jump to boundary');


  // Boundary enforcement
  print('\n--- Boundary enforcement ---');
  print('enforceBoundary: clamps to new range');
  print('Only when was in range before');
  print('Defers to parent physics otherwise');

  // Integration
  print('\n--- Using with ListView ---');
  print('ListView(');
  print('  physics: RangeMaintainingScrollPhysics(),');
  print('  children: dynamicItems,');
  print(')');

  print('\n' + '=' * 50);
  print('RangeMaintainingScrollPhysics test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'RangeMaintainingScrollPhysics Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Type: ScrollPhysics'),
      Text('Method: adjustPositionForNewDimensions'),
      Text('Use: dynamic content'),
    ],
  );
}
