// D4rt test script: Tests FabEndOffsetX from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('FabEndOffsetX test executing');
  print('=' * 50);

  // FabEndOffsetX mixin for end-aligned FAB
  print('\nFabEndOffsetX:');
  print('Mixin for FloatingActionButtonLocation');
  print('Positions FAB at "end" of scaffold horizontally');

  // Purpose
  print('\nPurpose:');
  print('- X-axis offset calculation');
  print('- FAB at trailing edge');
  print('- "End" horizontal positioning');

  // getOffsetX method
  print('\nProvides getOffsetX method:');
  print('double getOffsetX(');
  print('  ScaffoldPrelayoutGeometry scaffoldGeometry,');
  print('  double adjustment,');
  print(')');
  print('\nReturns X offset for end-aligned FAB');

  // LTR vs RTL
  print('\nLTR vs RTL:');
  print('');
  print('LTR (Left-to-Right):');
  print('  - End = Right side');
  print('  - Most common position');
  print('');
  print('RTL (Right-to-Left):');
  print('  - End = Left side');
  print('  - Arabic, Hebrew layouts');

  // Used by
  print('\nUsed by FAB locations:');
  print('- FloatingActionButtonLocation.endFloat');
  print('- FloatingActionButtonLocation.endDocked');
  print('- FloatingActionButtonLocation.endContained');
  print('- FloatingActionButtonLocation.endTop');
  print('- FloatingActionButtonLocation.miniEndFloat');

  // Example usage
  print('\nExample usage:');
  print('Scaffold(');
  print('  floatingActionButton: FloatingActionButton(...),,');
  print('  floatingActionButtonLocation:');
  print('      FloatingActionButtonLocation.endFloat,');
  print(');');

  // Type hierarchy
  print('\nType hierarchy:');
  print('FabEndOffsetX (mixin)');
  print('  \u2514\u2500 Mixed into FAB location classes');

  // Explain purpose
  print('\nFabEndOffsetX purpose:');
  print('- Mixin for X offset');
  print('- End/trailing FAB position');
  print('- getOffsetX method');
  print('- RTL-aware positioning');
  print('- Most common horizontal position');

  print('\n' + '=' * 50);
  print('FabEndOffsetX test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'FabEndOffsetX Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Type: mixin'),
      Text('Method: getOffsetX'),
      Text('Position: end/trailing'),
      Text('Purpose: FAB X positioning'),
    ],
  );
}
