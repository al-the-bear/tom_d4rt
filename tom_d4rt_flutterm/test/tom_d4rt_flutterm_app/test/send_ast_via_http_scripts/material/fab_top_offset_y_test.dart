// D4rt test script: Tests FabTopOffsetY from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('FabTopOffsetY test executing');
  print('=' * 50);

  // FabTopOffsetY mixin for top-positioned FAB
  print('\nFabTopOffsetY:');
  print('Mixin for FloatingActionButtonLocation');
  print('Positions FAB at "top" of scaffold vertically');

  // Purpose
  print('\nPurpose:');
  print('- Y-axis offset calculation');
  print('- FAB near top of scaffold');
  print('- "Top" vertical positioning');

  // getOffsetY method
  print('\nProvides getOffsetY method:');
  print('double getOffsetY(');
  print('  ScaffoldPrelayoutGeometry scaffoldGeometry,');
  print('  double adjustment,');
  print(')');
  print('\nReturns Y offset for top-positioned FAB');

  // Top position considerations
  print('\nTop position considerations:');
  print('- Below AppBar if present');
  print('- Respects safe area');
  print('- Accounts for status bar');
  print('- 16dp standard padding');

  // Used by
  print('\nUsed by FAB locations:');
  print('- FloatingActionButtonLocation.endTop');
  print('- FloatingActionButtonLocation.startTop');
  print('- FloatingActionButtonLocation.miniEndTop');
  print('- FloatingActionButtonLocation.miniStartTop');

  // Use cases
  print('\nUse cases:');
  print('- Quick action near app bar');
  print('- Primary action visibility');
  print('- Alternative to bottom FAB');
  print('- Chat compose buttons');

  // Example usage
  print('\nExample usage:');
  print('Scaffold(');
  print('  floatingActionButton: FloatingActionButton(...),,');
  print('  floatingActionButtonLocation:');
  print('      FloatingActionButtonLocation.endTop,');
  print(');');

  // Type hierarchy
  print('\nType hierarchy:');
  print('FabTopOffsetY (mixin)');
  print('  \u2514\u2500 Mixed into FAB location classes');

  // Explain purpose
  print('\nFabTopOffsetY purpose:');
  print('- Mixin for Y offset');
  print('- Top FAB positioning');
  print('- getOffsetY method');
  print('- Below app bar');
  print('- Used by top FAB locations');

  print('\n' + '=' * 50);
  print('FabTopOffsetY test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'FabTopOffsetY Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Type: mixin'),
      Text('Method: getOffsetY'),
      Text('Position: top'),
      Text('Purpose: FAB Y positioning'),
    ],
  );
}
