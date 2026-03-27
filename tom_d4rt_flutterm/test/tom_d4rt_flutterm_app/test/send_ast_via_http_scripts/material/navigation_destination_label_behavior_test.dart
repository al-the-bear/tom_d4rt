// ignore_for_file: avoid_print, deprecated_member_use
// D4rt test script: Tests NavigationDestinationLabelBehavior from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('NavigationDestinationLabelBehavior test executing');
  print('=' * 50);

  // NavigationDestinationLabelBehavior is an enum with 3 values
  print('NavigationDestinationLabelBehavior enum values:');
  for (final behavior in NavigationDestinationLabelBehavior.values) {
    print('  ${behavior.name}: index=${behavior.index}');
  }
  print('NavigationDestinationLabelBehavior has ${NavigationDestinationLabelBehavior.values.length} values');

  // Test first and last
  final first = NavigationDestinationLabelBehavior.values.first;
  final last = NavigationDestinationLabelBehavior.values.last;
  print('\nFirst value: $first (index ${first.index})');
  print('Last value: $last (index ${last.index})');

  // Test alwaysShow
  print('\nTesting NavigationDestinationLabelBehavior.alwaysShow:');
  final alwaysShow = NavigationDestinationLabelBehavior.alwaysShow;
  print('  name: ${alwaysShow.name}');
  print('  index: ${alwaysShow.index}');
  print('  toString: $alwaysShow');
  print('  Purpose: Labels always visible');

  // Test alwaysHide
  print('\nTesting NavigationDestinationLabelBehavior.alwaysHide:');
  final alwaysHide = NavigationDestinationLabelBehavior.alwaysHide;
  print('  name: ${alwaysHide.name}');
  print('  index: ${alwaysHide.index}');
  print('  Purpose: Labels never shown');

  // Test onlyShowSelected
  print('\nTesting NavigationDestinationLabelBehavior.onlyShowSelected:');
  final onlyShowSelected = NavigationDestinationLabelBehavior.onlyShowSelected;
  print('  name: ${onlyShowSelected.name}');
  print('  index: ${onlyShowSelected.index}');
  print('  Purpose: Only selected destination shows label');
  print('  Animation: Fades in, icon slides up');

  // Test equality
  print('\nEquality tests:');
  print('alwaysShow == alwaysShow: ${alwaysShow == alwaysShow}');
  print('alwaysShow == alwaysHide: ${alwaysShow == alwaysHide}');
  print('alwaysHide == onlyShowSelected: ${alwaysHide == onlyShowSelected}');

  // Usage with NavigationBar
  print('\nUsage with NavigationBar:');
  int selectedIndex = 0;
  final navBar1 = NavigationBar(
    selectedIndex: selectedIndex,
    labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
    destinations: [
      NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
      NavigationDestination(icon: Icon(Icons.search), label: 'Search'),
    ],
  );
  print('NavigationBar with alwaysShow created');

  final navBar2 = NavigationBar(
    selectedIndex: 0,
    labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
    destinations: [
      NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
      NavigationDestination(icon: Icon(Icons.settings), label: 'Settings'),
    ],
  );
  print('NavigationBar with alwaysHide created');

  final navBar3 = NavigationBar(
    selectedIndex: 1,
    labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
    destinations: [
      NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
      NavigationDestination(icon: Icon(Icons.person), label: 'Profile'),
    ],
  );
  print('NavigationBar with onlyShowSelected created');

  // Index ordering
  print('\nIndex ordering:');
  print('alwaysShow.index: ${alwaysShow.index}');
  print('alwaysHide.index: ${alwaysHide.index}');
  print('onlyShowSelected.index: ${onlyShowSelected.index}');

  // Use cases
  print('\nUse cases:');
  print('alwaysShow: Clear navigation, accessibility');
  print('alwaysHide: Icon-only compact nav');
  print('onlyShowSelected: Material 3 animated nav');

  print('\n' + '=' * 50);
  print('NavigationDestinationLabelBehavior test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('NavigationDestinationLabelBehavior Tests', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      SizedBox(height: 8),
      Text('Values: ${NavigationDestinationLabelBehavior.values.length}'),
      Text('alwaysShow: all labels visible'),
      Text('alwaysHide: no labels'),
      Text('onlyShowSelected: animated'),
    ],
  );
}
