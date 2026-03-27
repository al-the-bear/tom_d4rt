// ignore_for_file: avoid_print, deprecated_member_use
// D4rt test script: Tests ListTileControlAffinity from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('ListTileControlAffinity test executing');
  print('=' * 50);

  // ListTileControlAffinity is an enum with 3 values
  print('ListTileControlAffinity enum values:');
  for (final affinity in ListTileControlAffinity.values) {
    print('  ${affinity.name}: index=${affinity.index}');
  }
  print('ListTileControlAffinity has ${ListTileControlAffinity.values.length} values');

  // Test first and last
  final first = ListTileControlAffinity.values.first;
  final last = ListTileControlAffinity.values.last;
  print('\nFirst value: $first (index ${first.index})');
  print('Last value: $last (index ${last.index})');

  // Test leading
  print('\nTesting ListTileControlAffinity.leading:');
  final leading = ListTileControlAffinity.leading;
  print('  name: ${leading.name}');
  print('  index: ${leading.index}');
  print('  toString: $leading');
  print('  Purpose: Control on leading, secondary on trailing');

  // Test trailing
  print('\nTesting ListTileControlAffinity.trailing:');
  final trailing = ListTileControlAffinity.trailing;
  print('  name: ${trailing.name}');
  print('  index: ${trailing.index}');
  print('  Purpose: Control on trailing, secondary on leading');

  // Test platform
  print('\nTesting ListTileControlAffinity.platform:');
  final platform = ListTileControlAffinity.platform;
  print('  name: ${platform.name}');
  print('  index: ${platform.index}');
  print('  Purpose: Platform-typical position');

  // Test equality
  print('\nEquality tests:');
  print('leading == leading: ${leading == leading}');
  print('leading == trailing: ${leading == trailing}');
  print('trailing == platform: ${trailing == platform}');

  // Usage with CheckboxListTile
  print('\nUsage with CheckboxListTile:');
  final checkbox1 = CheckboxListTile(
    value: true,
    onChanged: (v) {},
    title: Text('Leading'),
    controlAffinity: ListTileControlAffinity.leading,
  );
  print('CheckboxListTile with leading created');

  final checkbox2 = CheckboxListTile(
    value: false,
    onChanged: (v) {},
    title: Text('Trailing'),
    controlAffinity: ListTileControlAffinity.trailing,
  );
  print('CheckboxListTile with trailing created');

  // Usage with SwitchListTile
  print('\nUsage with SwitchListTile:');
  final switch1 = SwitchListTile(
    value: true,
    onChanged: (v) {},
    title: Text('Platform'),
    controlAffinity: ListTileControlAffinity.platform,
  );
  print('SwitchListTile with platform created');

  // Usage with RadioListTile
  print('\nUsage with RadioListTile:');
  final radio = RadioListTile<int>(
    value: 1,
    groupValue: 1,
    onChanged: (v) {},
    title: Text('Leading Radio'),
    controlAffinity: ListTileControlAffinity.leading,
  );
  print('RadioListTile with leading created');

  // Index ordering
  print('\nIndex ordering:');
  print('leading.index: ${leading.index}');
  print('trailing.index: ${trailing.index}');
  print('platform.index: ${platform.index}');

  // Platform behavior
  print('\nPlatform behavior:');
  print('iOS: trailing (checkmark on right)');
  print('Android: leading (checkbox on left)');

  print('\n' + '=' * 50);
  print('ListTileControlAffinity test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('ListTileControlAffinity Tests', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      SizedBox(height: 8),
      Text('Values: ${ListTileControlAffinity.values.length}'),
      Text('leading: control on left'),
      Text('trailing: control on right'),
      Text('platform: system default'),
    ],
  );
}
