// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests WidgetStateMapper from widgets
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('WidgetStateMapper test executing');
  print('=' * 50);

  // WidgetStateMapper maps states to values
  print('WidgetStateMapper overview:');
  print('  - Class with Diagnosticable mixin');
  print('  - Implements WidgetStateProperty<T>');
  print('  - Uses WidgetStateMap for resolution');

  // Create mapper with a map
  print('\nCreating mapper with state map:');
  final mapper = WidgetStateMapper<double>({
    WidgetState.pressed: 2.0,
    WidgetState.hovered: 1.5,
    WidgetState.any: 1.0,
  });
  print('  Created mapper: $mapper');

  // Resolve with empty states (matches any)
  print('\nResolving with empty states:');
  final defaultVal = mapper.resolve({});
  print('  Empty states: $defaultVal');
  print('  Expected 1.0 (any): ${defaultVal == 1.0}');

  // Resolve with pressed
  print('\nResolving with pressed:');
  final pressedVal = mapper.resolve({WidgetState.pressed});
  print('  Pressed: $pressedVal');
  print('  Expected 2.0: ${pressedVal == 2.0}');

  // Resolve with hovered
  print('\nResolving with hovered:');
  final hoveredVal = mapper.resolve({WidgetState.hovered});
  print('  Hovered: $hoveredVal');
  print('  Expected 1.5: ${hoveredVal == 1.5}');

  // Resolve with unmatched state (falls to any)
  print('\nResolving with disabled (not in map):');
  final disabledVal = mapper.resolve({WidgetState.disabled});
  print('  Disabled: $disabledVal');
  print('  Falls to any: ${disabledVal == 1.0}');

  // Multiple states (first match wins)
  print('\nResolving with multiple states:');
  final multiVal = mapper.resolve({WidgetState.pressed, WidgetState.hovered});
  print('  Pressed+Hovered: $multiVal');
  print('  First match: pressed=2.0 or hovered=1.5');

  // Without any fallback
  print('\nMapper without any fallback:');
  final noFallback = WidgetStateMapper<String>({
    WidgetState.selected: 'selected',
  });
  final unmatched = noFallback.resolve({WidgetState.focused});
  print('  Unmatched returns: $unmatched');

  // Diagnosticable
  print('\nDiagnosticable support:');
  print('  - debugFillProperties available');
  print('  - Shows in widget inspector');

  print('\n' + '=' * 50);
  print('WidgetStateMapper test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'WidgetStateMapper Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Type: WidgetStateMapper<T>'),
      Text('Uses: WidgetStateMap for mapping'),
      Text('Fallback: WidgetState.any'),
    ],
  );
}
