// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests TabPageSelectorIndicator from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('TabPageSelectorIndicator test executing');
  print('=' * 50);

  // TabPageSelectorIndicator overview
  print('TabPageSelectorIndicator overview:');
  print('  - Single page indicator dot');
  print('  - Used by TabPageSelector');
  print('  - Shows selection state');

  // Test basic indicator
  print('\nTest basic indicator:');
  final ind1 = TabPageSelectorIndicator(
    backgroundColor: Colors.grey,
    borderColor: Colors.black,
    size: 12.0,
  );
  print('  BackgroundColor: ${ind1.backgroundColor}');
  print('  BorderColor: ${ind1.borderColor}');
  print('  Size: ${ind1.size}');

  // Test selected indicator
  print('\nTest selected indicator (filled):');
  final ind2 = TabPageSelectorIndicator(
    backgroundColor: Colors.blue,
    borderColor: Colors.blue,
    size: 12.0,
  );
  print('  BackgroundColor: ${ind2.backgroundColor}');
  print('  BorderColor: ${ind2.borderColor}');

  // Test unselected indicator
  print('\nTest unselected indicator (hollow):');
  final ind3 = TabPageSelectorIndicator(
    backgroundColor: Colors.transparent,
    borderColor: Colors.blue,
    size: 12.0,
  );
  print('  BackgroundColor: ${ind3.backgroundColor}');
  print('  BorderColor: ${ind3.borderColor}');

  // Test different sizes
  print('\nTest different sizes:');
  for (final size in [8.0, 12.0, 16.0, 20.0]) {
    final ind = TabPageSelectorIndicator(
      backgroundColor: Colors.blue,
      borderColor: Colors.blue,
      size: size,
    );
    print('  Size $size: ${ind.size}');
  }

  // Visual appearance
  print('\nVisual appearance:');
  print('  - Circular shape');
  print('  - Border width: 1.0');
  print('  - Smooth color transitions');

  // Usage in TabPageSelector
  print('\nUsage in TabPageSelector:');
  print('  TabPageSelector builds multiple indicators');
  print('  Selected: filled background');
  print('  Unselected: transparent background');

  // Animation
  print('\nAnimation:');
  print('  - Animates between states');
  print('  - Follows TabController');

  print('\n' + '=' * 50);
  print('TabPageSelectorIndicator test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('TabPageSelectorIndicator Tests', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      SizedBox(height: 8),
      Text('Type: StatelessWidget'),
      Text('Purpose: Single page dot'),
      Row(
        mainAxisSize: MainAxisSize.min,
        children: [ind1, SizedBox(width: 4), ind2, SizedBox(width: 4), ind3],
      ),
    ],
  );
}
