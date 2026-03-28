// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests TooltipVisibility from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('TooltipVisibility test executing');
  print('=' * 50);

  // TooltipVisibility overview
  print('TooltipVisibility overview:');
  print('  - Controls tooltip visibility');
  print('  - StatelessWidget');
  print('  - Uses InheritedWidget pattern');

  // Test visible=true
  print('\nTest visible=true:');
  final vis1 = TooltipVisibility(
    visible: true,
    child: Tooltip(message: 'Visible tooltip', child: Text('Hover me')),
  );
  print('  Visible: ${vis1.visible}');
  print('  Tooltips enabled');

  // Test visible=false
  print('\nTest visible=false:');
  final vis2 = TooltipVisibility(
    visible: false,
    child: Tooltip(message: 'Hidden tooltip', child: Text('No tooltip')),
  );
  print('  Visible: ${vis2.visible}');
  print('  Tooltips disabled');

  // Test nested
  print('\nTest nested visibility:');
  print('  TooltipVisibility can nest:');
  print('  Outer: visible=false disables tooltips');
  print('  Inner: visible=true re-enables (overrides)');
  print('  Children inherit nearest ancestor');
  print('  Can selectively control regions');
  print('  Example:');
  print('    TooltipVisibility(visible: false, child: Column(...))');  

  // Static method
  print('\nStatic isVisible method:');
  print('  TooltipVisibility.isVisible(context)');
  print('  Returns bool');
  print('  Default: true');

  // Use cases
  print('\nUse cases:');
  print('  - Disable tooltips in drag mode');
  print('  - Disable during animations');
  print('  - Context-specific control');
  print('  - Accessibility overrides');

  // Build behavior
  print('\nBuild behavior:');
  print('  Wraps child with _TooltipVisibilityScope');
  print('  InheritedWidget propagates visibility');

  // Related classes
  print('\nRelated classes:');
  print('  - Tooltip');
  print('  - TooltipTheme');
  print('  - TooltipState');

  // Usage pattern
  print('\nUsage pattern:');
  print('  TooltipVisibility(');
  print('    visible: !isDragging,');
  print('    child: MyWidgetWithTooltips(),');
  print('  )');

  print('\n' + '=' * 50);
  print('TooltipVisibility test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('TooltipVisibility Tests', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      SizedBox(height: 8),
      Text('Type: StatelessWidget'),
      Text('Purpose: Tooltip control'),
      vis1,
    ],
  );
}
