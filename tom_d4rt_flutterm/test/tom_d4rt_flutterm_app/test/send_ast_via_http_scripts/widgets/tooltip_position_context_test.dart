// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests TooltipPositionContext from widgets
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('TooltipPositionContext test executing');
  print('=' * 50);

  // TooltipPositionContext is data for positioning tooltips
  print('TooltipPositionContext overview:');
  print('  - @immutable data class');
  print('  - Contains positioning parameters');
  print('  - Used by TooltipPositionDelegate');
  print('  - Computes tooltip position');

  // Create test instance
  print('\nCreating test instance:');
  final ctx = TooltipPositionContext(
    target: Offset(100, 200),
    targetSize: Size(50, 30),
    tooltipSize: Size(120, 40),
    verticalOffset: 10.0,
    preferBelow: true,
    overlaySize: Size(400, 800),
  );

  // Test properties
  print('\nProperty values:');
  print('  target: ${ctx.target}');
  print('  targetSize: ${ctx.targetSize}');
  print('  tooltipSize: ${ctx.tooltipSize}');
  print('  verticalOffset: ${ctx.verticalOffset}');
  print('  preferBelow: ${ctx.preferBelow}');
  print('  overlaySize: ${ctx.overlaySize}');

  // Test defaults
  print('\nDefault values:');
  final defaults = TooltipPositionContext(
    target: Offset.zero,
    targetSize: Size.zero,
    tooltipSize: Size(100, 50),
    verticalOffset: 0,
  );
  print('  preferBelow default: ${defaults.preferBelow}');
  print('  overlaySize default: ${defaults.overlaySize}');

  // Equality
  print('\nEquality testing:');
  final ctx2 = TooltipPositionContext(
    target: Offset(100, 200),
    targetSize: Size(50, 30),
    tooltipSize: Size(120, 40),
    verticalOffset: 10.0,
    preferBelow: true,
    overlaySize: Size(400, 800),
  );
  print('  Same values equal: ${ctx == ctx2}');
  print('  hashCode matches: ${ctx.hashCode == ctx2.hashCode}');

  // Property descriptions
  print('\nProperty descriptions:');
  print('  - target: center point in global coords');
  print('  - targetSize: size of triggering widget');
  print('  - tooltipSize: size of tooltip itself');
  print('  - verticalOffset: gap from target');
  print('  - preferBelow: position preference');
  print('  - overlaySize: bounds for positioning');

  // Usage with delegate
  print('\nUsage with TooltipPositionDelegate:');
  print('  - Delegate receives context');
  print('  - Returns Offset for tooltip position');
  print('  - Can implement custom positioning');

  print('\n' + '=' * 50);
  print('TooltipPositionContext test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'TooltipPositionContext Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Type: Immutable data class'),
      Text('Properties: target, sizes, offset, preferBelow'),
      Text('Used by: TooltipPositionDelegate'),
    ],
  );
}
