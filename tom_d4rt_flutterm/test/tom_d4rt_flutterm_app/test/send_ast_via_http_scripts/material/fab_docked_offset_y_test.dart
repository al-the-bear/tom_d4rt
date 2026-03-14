// D4rt test script: Tests FabDockedOffsetY from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('FabDockedOffsetY test executing');
  print('=' * 50);

  // FabDockedOffsetY mixin for docked FAB position
  print('\nFabDockedOffsetY:');
  print('Mixin for FloatingActionButtonLocation');
  print('Positions FAB "docked" in BottomAppBar notch');

  // Purpose
  print('\nPurpose:');
  print('- Y-axis offset calculation');
  print('- FAB sits in BottomAppBar notch');
  print('- "Docked" vertical positioning');

  // getOffsetY method
  print('\nProvides getOffsetY method:');
  print('double getOffsetY(');
  print('  ScaffoldPrelayoutGeometry scaffoldGeometry,');
  print('  double adjustment,');
  print(')');
  print('\nReturns Y offset for docked FAB');

  // Docked vs Float
  print('\nDocked vs Float:');
  print('');
  print('Docked:');
  print('  - FAB in BottomAppBar notch');
  print('  - Half above, half in bar');
  print('  - Material 2 design');
  print('');
  print('Float:');
  print('  - FAB above bottom');
  print('  - Completely separate');
  print('  - Standard padding');

  // Used by
  print('\nUsed by FAB locations:');
  print('- FloatingActionButtonLocation.endDocked');
  print('- FloatingActionButtonLocation.centerDocked');
  print('- FloatingActionButtonLocation.startDocked');
  print('- FloatingActionButtonLocation.miniEndDocked');
  print('- FloatingActionButtonLocation.miniCenterDocked');
  print('- FloatingActionButtonLocation.miniStartDocked');

  // BottomAppBar integration
  print('\nBottomAppBar integration:');
  print('BottomAppBar(');
  print('  shape: CircularNotchedRectangle(),');
  print('  notchMargin: 8.0,');
  print('  child: Row(...),');
  print(');');

  // Example usage
  print('\nExample usage:');
  print('Scaffold(');
  print('  floatingActionButton: FloatingActionButton(...),,');
  print('  floatingActionButtonLocation:');
  print('      FloatingActionButtonLocation.centerDocked,');
  print('  bottomNavigationBar: BottomAppBar(...),');
  print(');');

  // Type hierarchy
  print('\nType hierarchy:');
  print('FabDockedOffsetY (mixin)');
  print('  \u2514\u2500 Mixed into FAB location classes');

  // Explain purpose
  print('\nFabDockedOffsetY purpose:');
  print('- Mixin for Y offset');
  print('- Docked FAB in notch');
  print('- getOffsetY method');
  print('- BottomAppBar integration');
  print('- Material 2 design pattern');

  print('\n' + '=' * 50);
  print('FabDockedOffsetY test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'FabDockedOffsetY Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Type: mixin'),
      Text('Method: getOffsetY'),
      Text('Style: docked/notched'),
      Text('Purpose: FAB Y positioning'),
    ],
  );
}
