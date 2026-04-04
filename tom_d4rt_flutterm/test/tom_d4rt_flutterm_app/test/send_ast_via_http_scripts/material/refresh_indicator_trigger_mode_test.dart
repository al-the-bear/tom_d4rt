// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests RefreshIndicatorTriggerMode from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('RefreshIndicatorTriggerMode test executing');
  print('=' * 50);

  // RefreshIndicatorTriggerMode enum
  print('RefreshIndicatorTriggerMode overview:');
  print('  - Enum for RefreshIndicator trigger');
  print('  - Used with RefreshIndicator widget');
  print('  - Controls when refresh can start');

  // All enum values
  print('\nAll RefreshIndicatorTriggerMode values:');
  for (final value in RefreshIndicatorTriggerMode.values) {
    print('  - ${value.name} (index: ${value.index})');
  }
  print('  Total: ${RefreshIndicatorTriggerMode.values.length} values');

  // Test individual values
  print('\nTesting individual values:');
  const anywhere = RefreshIndicatorTriggerMode.anywhere;
  const onEdge = RefreshIndicatorTriggerMode.onEdge;

  print('  anywhere: $anywhere');
  print('    - Drag can start from any scroll position');
  print('    - Even when not at top');
  print('    - More flexible');
  print('    - May conflict with scroll');

  print('  onEdge: $onEdge');
  print('    - Drag starts only at scroll edge');
  print('    - Must be at top of scrollable');
  print('    - Default behavior');
  print('    - Less conflict with scrolling');

  // Usage in RefreshIndicator
  print('\nUsage in RefreshIndicator:');
  print('  RefreshIndicator(');
  print('    triggerMode: RefreshIndicatorTriggerMode.onEdge,');
  print('    onRefresh: () async {');
  print('      await fetchData();');
  print('    },');
  print('    child: ListView(...),');
  print('  )');

  // First and last
  print('\nFirst and last:');
  final first = RefreshIndicatorTriggerMode.values.first;
  final last = RefreshIndicatorTriggerMode.values.last;
  print('  First: $first (index ${first.index})');
  print('  Last: $last (index ${last.index})');

  // Default value
  print('\nDefault: RefreshIndicatorTriggerMode.onEdge');

  // Use cases
  print('\nUse cases:');
  print('  onEdge: Standard pull-to-refresh');
  print('  anywhere: Custom gesture interactions');

  print('\n' + '=' * 50);
  print('RefreshIndicatorTriggerMode test completed');

  return SingleChildScrollView(child: Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'RefreshIndicatorTriggerMode Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Type: enum'),
      Text('Values: anywhere, onEdge'),
      Text('Use: Refresh trigger position'),
    ],
  ));
}
