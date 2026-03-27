// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests NavigationMode from widgets
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('NavigationMode test executing');
  print('=' * 50);

  // === Test NavigationMode enum ===
  print('\nNavigationMode indicates focus behavior');

  // Enumerate all values
  print('\nNavigationMode values:');
  for (final value in NavigationMode.values) {
    print('  ${value.name}: index=${value.index}');
  }
  print('NavigationMode has ${NavigationMode.values.length} values');

  // Test each value
  print('\n--- Testing NavigationMode.traditional ---');
  final traditional = NavigationMode.traditional;
  print('traditional: $traditional');
  print('traditional.index: ${traditional.index}');
  print('traditional.name: ${traditional.name}');
  print('Meaning: Focus indicators always visible');

  print('\n--- Testing NavigationMode.directional ---');
  final directional = NavigationMode.directional;
  print('directional: $directional');
  print('directional.index: ${directional.index}');
  print('directional.name: ${directional.name}');
  print('Meaning: Focus shown only during directional nav');

  // Test comparisons
  print('\n--- Testing comparisons ---');
  print('traditional == traditional: ${traditional == NavigationMode.traditional}');
  print('traditional == directional: ${traditional == directional}');
  print('traditional != directional: ${traditional != directional}');

  // Test first and last
  print('\n--- Testing first and last ---');
  final first = NavigationMode.values.first;
  final last = NavigationMode.values.last;
  print('First value: $first (index ${first.index})');
  print('Last value: $last (index ${last.index})');

  // Test hashCode
  print('\n--- Testing hashCode ---');
  print('traditional.hashCode: ${traditional.hashCode}');
  print('directional.hashCode: ${directional.hashCode}');

  // Usage with MediaQuery
  print('\n--- Usage with MediaQuery ---');
  final mediaQuery = MediaQuery.of(context);
  print('MediaQuery.navigationMode: ${mediaQuery.navigationMode}');

  print('\n' + '=' * 50);
  print('NavigationMode test completed');

  // Test toggle behavior
  print('\n--- Toggle considerations ---');
  print('Cannot toggle modes at runtime');
  print('Mode determined by system/MediaQuery');
  print('Apps adapt to current mode');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'NavigationMode Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Values: ${NavigationMode.values.length}'),
      Text('traditional: ${NavigationMode.traditional.index}'),
      Text('directional: ${NavigationMode.directional.index}'),
      Text('Current: ${MediaQuery.of(context).navigationMode}'),
    ],
  );
}
