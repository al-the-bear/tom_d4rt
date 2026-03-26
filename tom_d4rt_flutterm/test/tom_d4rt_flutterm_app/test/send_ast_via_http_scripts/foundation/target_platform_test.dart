// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests TargetPlatform from foundation
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('TargetPlatform test executing');
  print('=' * 50);

  // Enumerate all values
  print('\nTargetPlatform values:');
  for (final value in TargetPlatform.values) {
    print('  ${value.name}: index=${value.index}');
  }
  print('TargetPlatform has ${TargetPlatform.values.length} values');

  // First and last
  final first = TargetPlatform.values.first;
  final last = TargetPlatform.values.last;
  print('\nFirst: $first (${first.name}, index ${first.index})');
  print('Last: $last (${last.name}, index ${last.index})');

  // Specific platforms
  print('\nSpecific platforms:');
  print('android: ${TargetPlatform.android.name} (${TargetPlatform.android.index})');
  print('fuchsia: ${TargetPlatform.fuchsia.name} (${TargetPlatform.fuchsia.index})');
  print('iOS: ${TargetPlatform.iOS.name} (${TargetPlatform.iOS.index})');
  print('linux: ${TargetPlatform.linux.name} (${TargetPlatform.linux.index})');
  print('macOS: ${TargetPlatform.macOS.name} (${TargetPlatform.macOS.index})');
  print('windows: ${TargetPlatform.windows.name} (${TargetPlatform.windows.index})');

  // Current platform
  print('\nCurrent platform:');
  print('defaultTargetPlatform: $defaultTargetPlatform');
  print('defaultTargetPlatform.name: ${defaultTargetPlatform.name}');

  // Platform categorization
  print('\nMobile platforms:');
  final mobile = [TargetPlatform.android, TargetPlatform.iOS, TargetPlatform.fuchsia];
  for (final p in mobile) {
    print('  ${p.name} is mobile');
  }

  print('\nDesktop platforms:');
  final desktop = [TargetPlatform.linux, TargetPlatform.macOS, TargetPlatform.windows];
  for (final p in desktop) {
    print('  ${p.name} is desktop');
  }

  // Equality
  print('\nEquality tests:');
  print('android == android: ${TargetPlatform.android == TargetPlatform.android}');
  print('android == iOS: ${TargetPlatform.android == TargetPlatform.iOS}');
  print('identical: ${identical(TargetPlatform.linux, TargetPlatform.values[3])}');

  // Type checks
  print('\nType checks:');
  print('runtimeType: ${first.runtimeType}');
  print('is TargetPlatform: ${first is TargetPlatform}');
  print('is Enum: ${first is Enum}');

  // String representations
  print('\nString representations:');
  for (final value in TargetPlatform.values) {
    print('  $value => ${value.name}');
  }

  print('\n' + '=' * 50);
  print('TargetPlatform test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'TargetPlatform Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Values: ${TargetPlatform.values.length}'),
      Text('Current: $defaultTargetPlatform'),
      for (final v in TargetPlatform.values) Text('  ${v.name} (${v.index})'),
    ],
  );
}
