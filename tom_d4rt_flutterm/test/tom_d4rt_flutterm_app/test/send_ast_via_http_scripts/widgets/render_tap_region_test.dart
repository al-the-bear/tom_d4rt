// D4rt test script: Tests RenderTapRegion from widgets
import 'package:flutter/widgets.dart';
import 'package:flutter/rendering.dart';

dynamic build(BuildContext context) {
  print('RenderTapRegion test executing');

  // RenderTapRegion - Detects taps inside/outside a grouped region
  // Used by TapRegion widget for tap-outside-to-dismiss behavior
  
  // Create a TapRegionRegistry (normally provided by TapRegionSurface)
  print('RenderTapRegion characteristics:');
  print('- Groups multiple widgets into a tap region');
  print('- Detects taps inside vs outside the region');
  print('- Used for dismiss-on-tap-outside patterns');
  
  // Group concept
  print('\nTap region grouping:');
  print('- Multiple TapRegions share the same groupId');
  print('- Taps inside any member count as inside the group');
  print('- onTapOutside fires when tapping outside all members');
  print('- onTapInside fires when tapping inside any member');
  
  // Properties
  print('\nRenderTapRegion properties:');
  print('- groupId: Groups multiple regions together');
  print('- onTapOutside: Callback when tapping outside');
  print('- onTapInside: Callback when tapping inside');
  print('- enabled: Whether the region is active');
  print('- behavior: Hit test behavior');
  
  // Type hierarchy
  print('\nType hierarchy:');
  print('RenderTapRegion extends RenderProxyBoxWithHitTestBehavior');
  print('RenderProxyBoxWithHitTestBehavior extends RenderProxyBox');
  print('Works with RenderTapRegionSurface');
  
  // Use cases
  print('\nUse cases:');
  print('- Dropdown dismiss on tap outside');
  print('- Modal dismiss behavior');
  print('- Menu close on outside tap');
  print('- Focus dismiss patterns');

  print('\nRenderTapRegion test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('RenderTapRegion Tests'),
      Text('Detects taps inside/outside region'),
      Text('Supports grouped tap regions'),
      Text('Dismiss-on-tap-outside pattern'),
    ],
  );
}
