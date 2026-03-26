// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests SelectionRegistrant from rendering
import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('SelectionRegistrant test executing');
  print('=' * 50);

  // SelectionRegistrant is a mixin on Selectable
  print('\nSelectionRegistrant:');
  print('Type: mixin');
  print('Requires: Selectable (mixin on Selectable)');
  print('Purpose: Auto-registers with a SelectionRegistrar');
  print('Cannot be instantiated directly');

  // Properties
  print('\nProperties:');
  print('  registrar -> SelectionRegistrar? (get/set)');
  print('  When set, auto-calls registrar.add(this)');
  print('  When changed, calls old.remove(this) then new.add(this)');
  print('  When set to null, calls old.remove(this)');

  // Lifecycle
  print('\nLifecycle:');
  print('  1. Mixin applied: class MyRO extends RenderBox');
  print('       with Selectable, SelectionRegistrant');
  print('  2. registrar set (e.g., from parent)');
  print('  3. Auto-registered: registrar.add(this)');
  print('  4. Handles selection events via Selectable');
  print('  5. registrar changed: old.remove, new.add');
  print('  6. dispose: registrar.remove(this)');

  // Relationship in selection hierarchy
  print('\nSelection hierarchy:');
  print('  SelectionHandler (abstract interface)');
  print('    \u2514\u2500 Selectable (mixin, implements SelectionHandler)');
  print('         \u2514\u2500 SelectionRegistrant (mixin on Selectable)');
  print('  SelectionRegistrar (abstract, manages Selectables)');

  // Usage pattern
  print('\nUsage pattern:');
  print('  class MySelectable extends RenderBox');
  print('    with Selectable, SelectionRegistrant {');
  print('    @override');
  print('    Matrix4 getTransformTo(RenderObject? ancestor) => ...');
  print('    @override');
  print('    Size get size => ...');
  print('    @override');
  print('    List<Rect> get boundingBoxes => ...');
  print('  }');

  // Widget integration
  print('\nWidget integration:');
  print('  SelectableRegion widget manages the SelectionRegistrar');
  print('  RegistrarScope provides registrar to descendants');
  print('  Each SelectionRegistrant auto-registers when attached');

  // dispose behavior
  print('\ndispose behavior:');
  print('  On dispose, calls registrar.remove(this)');
  print('  Ensures no dangling references in the registry');
  print('  Must call super.dispose() to trigger cleanup');

  print('\n==================================================');
  print('SelectionRegistrant test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'SelectionRegistrant Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Type: Mixin on Selectable'),
      Text('Property: registrar (SelectionRegistrar?)'),
      Text('Auto-registers on set, auto-removes on dispose'),
      Text('Purpose: Automatic selection registration'),
    ],
  );
}
