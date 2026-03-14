// D4rt test script: Tests FabMiniOffsetAdjustment from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('FabMiniOffsetAdjustment test executing');
  print('=' * 50);

  // FabMiniOffsetAdjustment mixin for mini FAB
  print('\nFabMiniOffsetAdjustment:');
  print('Mixin for mini FAB positioning adjustment');
  print('Adjusts offset for smaller FAB size');

  // Purpose
  print('\nPurpose:');
  print('- Offset adjustment for mini FAB');
  print('- Account for size difference');
  print('- Maintain visual alignment');

  // Mini vs Regular FAB
  print('\nMini vs Regular FAB:');
  print('');
  print('Regular FAB:');
  print('  - 56.0 x 56.0 dp');
  print('  - Standard size');
  print('  - Primary action');
  print('');
  print('Mini FAB:');
  print('  - 40.0 x 40.0 dp');
  print('  - Smaller footprint');
  print('  - Secondary actions');

  // getOffsetAdjustment method
  print('\nProvides getOffsetAdjustment method:');
  print('double getOffsetAdjustment(');
  print('  ScaffoldPrelayoutGeometry scaffoldGeometry,');
  print(')');
  print('\nReturns adjustment for mini FAB size');

  // Adjustment calculation
  print('\nAdjustment calculation:');
  print('adjustment = (56.0 - 40.0) / 2 = 8.0');
  print('Keeps mini FAB visually aligned');
  print('with where regular FAB would be');

  // Used by
  print('\nUsed by FAB locations:');
  print('- FloatingActionButtonLocation.miniEndFloat');
  print('- FloatingActionButtonLocation.miniEndDocked');
  print('- FloatingActionButtonLocation.miniEndTop');
  print('- FloatingActionButtonLocation.miniCenterFloat');
  print('- FloatingActionButtonLocation.miniCenterDocked');
  print('- FloatingActionButtonLocation.miniCenterTop');
  print('- FloatingActionButtonLocation.miniStartFloat');
  print('- FloatingActionButtonLocation.miniStartDocked');
  print('- FloatingActionButtonLocation.miniStartTop');

  // Example usage
  print('\nExample usage:');
  print('Scaffold(');
  print('  floatingActionButton: FloatingActionButton.small(');
  print('    onPressed: () {},');
  print('    child: Icon(Icons.add),');
  print('  ),');
  print('  floatingActionButtonLocation:');
  print('      FloatingActionButtonLocation.miniEndFloat,');
  print(');');

  // Type hierarchy
  print('\nType hierarchy:');
  print('FabMiniOffsetAdjustment (mixin)');
  print('  \u2514\u2500 Mixed into mini FAB location classes');

  // Explain purpose
  print('\nFabMiniOffsetAdjustment purpose:');
  print('- Mixin for mini FAB');
  print('- getOffsetAdjustment method');
  print('- Size compensation');
  print('- Visual alignment');
  print('- Used by mini locations');

  print('\n' + '=' * 50);
  print('FabMiniOffsetAdjustment test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'FabMiniOffsetAdjustment Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Type: mixin'),
      Text('Method: getOffsetAdjustment'),
      Text('Mini size: 40x40'),
      Text('Purpose: Mini FAB positioning'),
    ],
  );
}
