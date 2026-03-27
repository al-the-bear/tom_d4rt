// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests StandardComponentType enum from widgets
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('StandardComponentType test executing');
  print('=' * 50);

  // Test enum values
  print('StandardComponentType values:');
  for (final type in StandardComponentType.values) {
    print('  ${type.name}: index=${type.index}');
  }
  print('StandardComponentType has ${StandardComponentType.values.length} values');

  // Test individual values with their keys
  print('\nDetailed value inspection with keys:');
  
  // backButton
  final backButton = StandardComponentType.backButton;
  print('\nbackButton:');
  print('  index: ${backButton.index}');
  print('  name: ${backButton.name}');
  print('  key: ${backButton.key}');
  print('  Purpose: Navigate back to previous screen');

  // closeButton
  final closeButton = StandardComponentType.closeButton;
  print('\ncloseButton:');
  print('  index: ${closeButton.index}');
  print('  name: ${closeButton.name}');
  print('  key: ${closeButton.key}');
  print('  Purpose: Dismiss dialog or modal sheet');

  // moreButton
  final moreButton = StandardComponentType.moreButton;
  print('\nmoreButton:');
  print('  index: ${moreButton.index}');
  print('  name: ${moreButton.name}');
  print('  key: ${moreButton.key}');
  print('  Purpose: Display menu of additional options');

  // drawerButton
  final drawerButton = StandardComponentType.drawerButton;
  print('\ndrawerButton:');
  print('  index: ${drawerButton.index}');
  print('  name: ${drawerButton.name}');
  print('  key: ${drawerButton.key}');
  print('  Purpose: Open a drawer');

  // Test key getter returns ValueKey
  print('\nKey getter verification:');
  print('  backButton.key runtimeType: ${backButton.key.runtimeType}');
  print('  Key value: ${(backButton.key as ValueKey).value}');

  // First and last
  print('\nRange verification:');
  print('  First: ${StandardComponentType.values.first}');
  print('  Last: ${StandardComponentType.values.last}');

  // Usage in testing
  print('\nUsage in testing (CommonFinders):');
  print('  - find.backButton() matches backButton type');
  print('  - find.closeButton() matches closeButton type');
  print('  - Helps create reliable test matchers');
  print('  - Avoids fragile text-based matching');

  print('\n' + '=' * 50);
  print('StandardComponentType test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'StandardComponentType Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Values: backButton, closeButton, moreButton, drawerButton'),
      Text('Properties: key getter returns ValueKey'),
      Text('Used by: CommonFinders for testing'),
    ],
  );
}
