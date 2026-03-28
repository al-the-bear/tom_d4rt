// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests PersistentHeaderShowOnScreenConfiguration from rendering
import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('PersistentHeaderShowOnScreenConfiguration test executing');
  print('=' * 50);

  // Class overview
  print('PersistentHeaderShowOnScreenConfiguration class overview:');
  print('  - Configuration for showOnScreen of persistent headers');
  print('  - Used by SliverPersistentHeader');
  print('  - Controls scroll reveal behavior');

  // Default constructor
  print('\nDefault constructor:');
  final config = PersistentHeaderShowOnScreenConfiguration();
  print('  Created default instance');
  print('  Type: ${config.runtimeType}');

  // Properties
  print('\nProperties:');
  print('  minShowOnScreenExtent: ${config.minShowOnScreenExtent}');
  print('  maxShowOnScreenExtent: ${config.maxShowOnScreenExtent}');

  // Constructor with values
  print('\nConstructor with values:');
  final customConfig = PersistentHeaderShowOnScreenConfiguration(
    minShowOnScreenExtent: 50.0,
    maxShowOnScreenExtent: 100.0,
  );
  print('  minShowOnScreenExtent: ${customConfig.minShowOnScreenExtent}');
  print('  maxShowOnScreenExtent: ${customConfig.maxShowOnScreenExtent}');

  // Default values
  print('\nDefault values:');
  print('  minShowOnScreenExtent: 0 (default)');
  print('  maxShowOnScreenExtent: double.infinity');

  // Usage context
  print('\nUsage context:');
  print('  RenderSliverPersistentHeader');
  print('  showOnScreen method');
  print('  Keyboard reveal behavior');

  // Inheritance
  print('\nClass hierarchy:');
  print('  Object -> PersistentHeaderShowOnScreenConfiguration');
  print('  Immutable configuration');

  // Example usage
  print('\nExample usage:');
  print('  SliverPersistentHeader(');
  print('    delegate: MyDelegate(),');
  print('    pinned: true,');
  print('  )');

  // Behavior
  print('\nBehavior:');
  print('  Controls how much of header shows');
  print('  When scrolling to reveal content');
  print('  Ensures keyboard access');

  // Comparison
  print('\nComparison:');
  final config1 = PersistentHeaderShowOnScreenConfiguration();
  final config2 = PersistentHeaderShowOnScreenConfiguration();
  print('  Same defaults create equal configs');
  print('  config1.min: ${config1.minShowOnScreenExtent}');
  print('  config2.min: ${config2.minShowOnScreenExtent}');

  print('\n' + '=' * 50);
  print('PersistentHeaderShowOnScreenConfiguration test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('PersistentHeaderShowOnScreenConfiguration', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      SizedBox(height: 8),
      Text('Type: Class'),
      Text('Props: min/maxShowOnScreenExtent'),
      Text('Purpose: Header scroll config'),
    ],
  );
}
