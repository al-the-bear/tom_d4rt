// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests NavigationDestinationLabelBehavior from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('NavigationDestinationLabelBehavior test executing');
  print('=' * 50);

  // NavigationDestinationLabelBehavior enum
  print('NavigationDestinationLabelBehavior overview:');
  print('  - Enum for NavigationBar label display');
  print('  - Used with NavigationBar widget');
  print('  - Controls when destination labels appear');

  // All enum values
  print('\nAll NavigationDestinationLabelBehavior values:');
  for (final value in NavigationDestinationLabelBehavior.values) {
    print('  - ${value.name} (index: ${value.index})');
  }
  print('  Total: ${NavigationDestinationLabelBehavior.values.length} values');

  // Test individual values
  print('\nTesting individual values:');
  const alwaysShow = NavigationDestinationLabelBehavior.alwaysShow;
  const alwaysHide = NavigationDestinationLabelBehavior.alwaysHide;
  const onlyShowSelected = NavigationDestinationLabelBehavior.onlyShowSelected;

  print('  alwaysShow: $alwaysShow');
  print('    - Labels visible for all destinations');
  print('    - All icons have text below');
  print('    - Default behavior');
  print('    - Recommended for accessibility');

  print('  alwaysHide: $alwaysHide');
  print('    - Labels never shown');
  print('    - Icons only navigation');
  print('    - Compact design');
  print('    - Less accessible');

  print('  onlyShowSelected: $onlyShowSelected');
  print('    - Label only for selected destination');
  print('    - Unselected show only icons');
  print('    - Material 2 style');
  print('    - Saves horizontal space');

  // Usage in NavigationBar
  print('\nUsage in NavigationBar:');
  print('  NavigationBar(');
  print('    labelBehavior:');
  print('      NavigationDestinationLabelBehavior.alwaysShow,');
  print('    destinations: [');
  print('      NavigationDestination(');
  print('        icon: Icon(Icons.home),');
  print('        label: "Home",');
  print('      ),');
  print('    ],');
  print('  )');

  // First and last
  print('\nFirst and last:');
  final first = NavigationDestinationLabelBehavior.values.first;
  final last = NavigationDestinationLabelBehavior.values.last;
  print('  First: $first (index ${first.index})');
  print('  Last: $last (index ${last.index})');

  // NavigationRail equivalent
  print('\nRelated:');
  print('  NavigationRailLabelType for NavigationRail');

  // Default value
  print('\nDefault: NavigationDestinationLabelBehavior.alwaysShow');

  print('\n' + '=' * 50);
  print('NavigationDestinationLabelBehavior test completed');

  return SingleChildScrollView(child: Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'NavigationDestinationLabelBehavior Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Type: enum'),
      Text('Values: alwaysShow, alwaysHide, onlyShowSelected'),
      Text('Use: NavigationBar labels'),
    ],
  ));
}
