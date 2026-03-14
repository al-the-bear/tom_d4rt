// D4rt test script: Tests FabFloatOffsetY from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('FabFloatOffsetY test executing');
  print('=' * 50);

  // FabFloatOffsetY mixin for floating FAB position
  print('\nFabFloatOffsetY:');
  print('Mixin for FloatingActionButtonLocation');
  print('Positions FAB "floating" above bottom edge');

  // Purpose
  print('\nPurpose:');
  print('- Y-axis offset calculation');
  print('- FAB floats above content');
  print('- "Float" positioning style');

  // getOffsetY method
  print('\nProvides getOffsetY method:');
  print('double getOffsetY(');
  print('  ScaffoldPrelayoutGeometry scaffoldGeometry,');
  print('  double adjustment,');
  print(')');
  print('\nReturns Y offset for floating FAB');

  // Used by
  print('\nUsed by FAB locations:');
  print('- FloatingActionButtonLocation.endFloat');
  print('- FloatingActionButtonLocation.centerFloat');
  print('- FloatingActionButtonLocation.startFloat');
  print('- FloatingActionButtonLocation.miniEndFloat');

  // Float vs Contained
  print('\nFloat vs Contained:');
  print('');
  print('Float:');
  print('  - Above bottom navigation');
  print('  - Standard 16dp padding');
  print('  - Default FAB position');
  print('');
  print('Contained:');
  print('  - Inside navigation bar notch');
  print('  - Material 3 style');

  // Example usage
  print('\nExample usage:');
  print('Scaffold(');
  print('  floatingActionButton: FloatingActionButton(...),,');
  print('  floatingActionButtonLocation:');
  print('      FloatingActionButtonLocation.endFloat,');
  print(');');

  // Type hierarchy
  print('\nType hierarchy:');
  print('FabFloatOffsetY (mixin)');
  print('  \u2514\u2500 Mixed into FAB location classes');

  // Explain purpose
  print('\nFabFloatOffsetY purpose:');
  print('- Mixin for Y offset');
  print('- Floating FAB positioning');
  print('- getOffsetY method');
  print('- Standard above-content style');
  print('- Most common FAB position');

  print('\n' + '=' * 50);
  print('FabFloatOffsetY test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'FabFloatOffsetY Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Type: mixin'),
      Text('Method: getOffsetY'),
      Text('Style: floating'),
      Text('Purpose: FAB Y positioning'),
    ],
  );
}
