// D4rt test script: Tests FabCenterOffsetX from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('FabCenterOffsetX test executing');
  print('=' * 50);

  // FabCenterOffsetX mixin for center-aligned FAB
  print('\nFabCenterOffsetX:');
  print('Mixin for FloatingActionButtonLocation');
  print('Positions FAB at "center" of scaffold horizontally');

  // Purpose
  print('\nPurpose:');
  print('- X-axis offset calculation');
  print('- FAB at horizontal center');
  print('- "Center" horizontal positioning');

  // getOffsetX method
  print('\nProvides getOffsetX method:');
  print('double getOffsetX(');
  print('  ScaffoldPrelayoutGeometry scaffoldGeometry,');
  print('  double adjustment,');
  print(')');
  print('\nReturns X offset for centered FAB');

  // Center calculation
  print('\nCenter calculation:');
  print('x = (scaffoldWidth - fabWidth) / 2');
  print('Adjusted for mini FAB size if needed');

  // Used by
  print('\nUsed by FAB locations:');
  print('- FloatingActionButtonLocation.centerFloat');
  print('- FloatingActionButtonLocation.centerDocked');
  print('- FloatingActionButtonLocation.centerTop');
  print('- FloatingActionButtonLocation.miniCenterFloat');
  print('- FloatingActionButtonLocation.miniCenterDocked');
  print('- FloatingActionButtonLocation.miniCenterTop');

  // Use cases
  print('\nUse cases:');
  print('- Primary centered action');
  print('- With BottomNavigationBar');
  print('- Prominent FAB placement');
  print('- Camera/create buttons');

  // Example usage
  print('\nExample usage:');
  print('Scaffold(');
  print('  floatingActionButton: FloatingActionButton(...),,');
  print('  floatingActionButtonLocation:');
  print('      FloatingActionButtonLocation.centerFloat,');
  print('  bottomNavigationBar: BottomNavigationBar(...),');
  print(');');

  // Type hierarchy
  print('\nType hierarchy:');
  print('FabCenterOffsetX (mixin)');
  print('  \u2514\u2500 Mixed into FAB location classes');

  // Explain purpose
  print('\nFabCenterOffsetX purpose:');
  print('- Mixin for X offset');
  print('- Center FAB position');
  print('- getOffsetX method');
  print('- Horizontal centering');
  print('- Used by center FAB locations');

  print('\n' + '=' * 50);
  print('FabCenterOffsetX test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'FabCenterOffsetX Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Type: mixin'),
      Text('Method: getOffsetX'),
      Text('Position: center'),
      Text('Purpose: FAB X positioning'),
    ],
  );
}
