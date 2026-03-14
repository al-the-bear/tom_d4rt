// D4rt test script: Tests FabStartOffsetX from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('FabStartOffsetX test executing');
  print('=' * 50);

  // FabStartOffsetX mixin for start-aligned FAB
  print('\nFabStartOffsetX:');
  print('Mixin for FloatingActionButtonLocation');
  print('Positions FAB at "start" of scaffold horizontally');

  // Purpose
  print('\nPurpose:');
  print('- X-axis offset calculation');
  print('- FAB at leading edge');
  print('- "Start" horizontal positioning');

  // getOffsetX method
  print('\nProvides getOffsetX method:');
  print('double getOffsetX(');
  print('  ScaffoldPrelayoutGeometry scaffoldGeometry,');
  print('  double adjustment,');
  print(')');
  print('\nReturns X offset for start-aligned FAB');

  // LTR vs RTL
  print('\nLTR vs RTL:');
  print('');
  print('LTR (Left-to-Right):');
  print('  - Start = Left side');
  print('  - Less common position');
  print('');
  print('RTL (Right-to-Left):');
  print('  - Start = Right side');
  print('  - Arabic, Hebrew layouts');

  // Used by
  print('\nUsed by FAB locations:');
  print('- FloatingActionButtonLocation.startFloat');
  print('- FloatingActionButtonLocation.startDocked');
  print('- FloatingActionButtonLocation.startTop');
  print('- FloatingActionButtonLocation.miniStartFloat');
  print('- FloatingActionButtonLocation.miniStartDocked');
  print('- FloatingActionButtonLocation.miniStartTop');

  // Use cases
  print('\nUse cases:');
  print('- Alternative to end position');
  print('- Left-handed accessibility');
  print('- Specific UX requirements');
  print('- Navigation patterns');

  // Example usage
  print('\nExample usage:');
  print('Scaffold(');
  print('  floatingActionButton: FloatingActionButton(...),,');
  print('  floatingActionButtonLocation:');
  print('      FloatingActionButtonLocation.startFloat,');
  print(');');

  // Type hierarchy
  print('\nType hierarchy:');
  print('FabStartOffsetX (mixin)');
  print('  \u2514\u2500 Mixed into FAB location classes');

  // Explain purpose
  print('\nFabStartOffsetX purpose:');
  print('- Mixin for X offset');
  print('- Start/leading FAB position');
  print('- getOffsetX method');
  print('- RTL-aware positioning');
  print('- Less common horizontal position');

  print('\n' + '=' * 50);
  print('FabStartOffsetX test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'FabStartOffsetX Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Type: mixin'),
      Text('Method: getOffsetX'),
      Text('Position: start/leading'),
      Text('Purpose: FAB X positioning'),
    ],
  );
}
