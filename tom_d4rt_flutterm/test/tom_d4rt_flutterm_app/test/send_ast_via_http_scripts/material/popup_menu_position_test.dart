// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests PopupMenuPosition from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('PopupMenuPosition test executing');
  print('=' * 50);

  // PopupMenuPosition enum
  print('PopupMenuPosition overview:');
  print('  - Enum for popup menu positioning');
  print('  - Used with PopupMenuButton');
  print('  - Controls menu placement');

  // All enum values
  print('\nAll PopupMenuPosition values:');
  for (final value in PopupMenuPosition.values) {
    print('  - ${value.name} (index: ${value.index})');
  }
  print('  Total: ${PopupMenuPosition.values.length} values');

  // Test individual values
  print('\nTesting individual values:');
  const over = PopupMenuPosition.over;
  const under = PopupMenuPosition.under;

  print('  over: $over');
  print('    - Menu overlaps anchor button');
  print('    - Selected item aligns with button');
  print('    - Material 2 style');
  print('    - Dense layout');

  print('  under: $under');
  print('    - Menu appears below button');
  print('    - Button stays visible');
  print('    - Material 3 style');
  print('    - Dropdown appearance');

  // Usage in PopupMenuButton
  print('\nUsage in PopupMenuButton:');
  print('  PopupMenuButton<String>(');
  print('    position: PopupMenuPosition.under,');
  print('    itemBuilder: (context) => [');
  print('      PopupMenuItem(');
  print('        value: "edit",');
  print('        child: Text("Edit"),');
  print('      ),');
  print('      PopupMenuItem(');
  print('        value: "delete",');
  print('        child: Text("Delete"),');
  print('      ),');
  print('    ],');
  print('  )');

  // First and last
  print('\nFirst and last:');
  final first = PopupMenuPosition.values.first;
  final last = PopupMenuPosition.values.last;
  print('  First: $first (index ${first.index})');
  print('  Last: $last (index ${last.index})');

  // Default value
  print('\nDefault: PopupMenuPosition.over');
  print('  Material 3 recommends .under');

  // Theme configuration
  print('\nTheme configuration:');
  print('  PopupMenuThemeData(');
  print('    position: PopupMenuPosition.under,');
  print('  )');

  print('\n' + '=' * 50);
  print('PopupMenuPosition test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'PopupMenuPosition Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Type: enum'),
      Text('Values: over, under'),
      Text('Use: Popup menu placement'),
    ],
  );
}
