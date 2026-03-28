// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests SwitchListTile from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('SwitchListTile test executing');
  print('=' * 50);

  // SwitchListTile overview
  print('SwitchListTile overview:');
  print('  - ListTile with a Switch');
  print('  - Tapping toggles the switch');
  print('  - Combines ListTile and Switch');

  // Test basic SwitchListTile
  print('\nTest basic SwitchListTile:');
  final tile1 = SwitchListTile(
    value: true,
    onChanged: (v) {},
    title: Text('Basic Switch'),
  );
  print('  Value: ${tile1.value}');
  print('  Has onChanged: ${tile1.onChanged != null}');

  // Test with subtitle
  print('\nTest with subtitle:');
  final tile2 = SwitchListTile(
    value: false,
    onChanged: (v) {},
    title: Text('WiFi'),
    subtitle: Text('Connect to wireless network'),
  );
  print('  Has title: ${tile2.title != null}');
  print('  Has subtitle: ${tile2.subtitle != null}');

  // Test with secondary widget
  print('\nTest with secondary widget:');
  final tile3 = SwitchListTile(
    value: true,
    onChanged: (v) {},
    title: Text('Notifications'),
    secondary: Icon(Icons.notifications),
  );
  print('  Has secondary: ${tile3.secondary != null}');

  // Test adaptive switch
  print('\nTest adaptive switch:');
  final tile4 = SwitchListTile.adaptive(
    value: true,
    onChanged: (v) {},
    title: Text('Adaptive'),
  );
  print('  Created adaptive: ${tile4.runtimeType}');

  // Test disabled
  print('\nTest disabled state:');
  final tile5 = SwitchListTile(
    value: true,
    onChanged: null,
    title: Text('Disabled'),
  );
  print('  Enabled: ${tile5.onChanged != null}');

  // Test colors
  print('\nTest switch colors:');
  final tile6 = SwitchListTile(
    value: true,
    onChanged: (v) {},
    title: Text('Colored'),
    activeColor: Colors.green,
    activeTrackColor: Colors.lightGreen,
    inactiveThumbColor: Colors.grey,
    inactiveTrackColor: Colors.black12,
  );
  print('  ActiveColor: ${tile6.activeColor}');
  print('  ActiveTrackColor: ${tile6.activeTrackColor}');

  // Test thumb properties
  print('\nTest thumb properties:');
  final tile7 = SwitchListTile(
    value: true,
    onChanged: (v) {},
    title: Text('Thumb'),
    thumbColor: WidgetStateProperty.all(Colors.white),
    thumbIcon: WidgetStateProperty.all(Icon(Icons.check, size: 14)),
  );
  print('  Has thumbColor: ${tile7.thumbColor != null}');
  print('  Has thumbIcon: ${tile7.thumbIcon != null}');

  // Control affinity
  print('\nControl affinity:');
  print('  ListTileControlAffinity.leading - switch on left');
  print('  ListTileControlAffinity.trailing - switch on right');
  print('  ListTileControlAffinity.platform - platform default');

  print('\n' + '=' * 50);
  print('SwitchListTile test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('SwitchListTile Tests', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      SizedBox(height: 8),
      Text('Type: StatelessWidget'),
      Text('Purpose: ListTile with Switch'),
    ],
  );
}
