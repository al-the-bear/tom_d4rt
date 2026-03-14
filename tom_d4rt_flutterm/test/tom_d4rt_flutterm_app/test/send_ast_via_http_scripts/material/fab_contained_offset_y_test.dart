// D4rt test script: Tests FabContainedOffsetY from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('FabContainedOffsetY test executing');
  print('=' * 50);

  // FabContainedOffsetY mixin for FAB positioning
  print('\nFabContainedOffsetY:');
  print('Mixin for FloatingActionButtonLocation');
  print('Positions FAB "contained" above bottom bar');

  // Purpose
  print('\nPurpose:');
  print('- Y-axis offset calculation');
  print('- FAB sits inside/above app bar');
  print('- "Contained" positioning style');

  // getOffsetY method
  print('\nProvides getOffsetY method:');
  print('double getOffsetY(');
  print('  ScaffoldPrelayoutGeometry scaffoldGeometry,');
  print('  double adjustment,');
  print(')');
  print('\nReturns Y offset for FAB');

  // Used by
  print('\nUsed by FAB locations:');
  print('- FloatingActionButtonLocation.endContained');
  print('- FloatingActionButtonLocation.centerFloat');

  // ScaffoldPrelayoutGeometry
  print('\nScaffoldPrelayoutGeometry provides:');
  print('- bottomSheetSize');
  print('- contentBottom');
  print('- contentTop');
  print('- floatingActionButtonSize');
  print('- minInsets');
  print('- scaffoldSize');
  print('- snackBarSize');

  // Example usage
  print('\nExample usage:');
  print('Scaffold(');
  print('  floatingActionButton: FloatingActionButton(...),,');
  print('  floatingActionButtonLocation:');
  print('      FloatingActionButtonLocation.endContained,');
  print(');');

  // Type hierarchy
  print('\nType hierarchy:');
  print('FabContainedOffsetY (mixin)');
  print('  \u2514\u2500 Mixed into FAB location classes');

  // Explain purpose
  print('\nFabContainedOffsetY purpose:');
  print('- Mixin for Y offset');
  print('- Contained FAB positioning');
  print('- getOffsetY method');
  print('- Above bottom navigation');
  print('- Used by FloatingActionButtonLocation');

  print('\n' + '=' * 50);
  print('FabContainedOffsetY test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'FabContainedOffsetY Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Type: mixin'),
      Text('Method: getOffsetY'),
      Text('Style: contained'),
      Text('Purpose: FAB Y positioning'),
    ],
  );
}
