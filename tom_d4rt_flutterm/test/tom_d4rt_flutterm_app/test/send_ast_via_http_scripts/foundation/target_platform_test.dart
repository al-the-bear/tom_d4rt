// ignore_for_file: avoid_print, deprecated_member_use
// D4rt test script: Tests TargetPlatform from foundation
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('TargetPlatform test executing');
  print('=' * 50);

  // TargetPlatform is an enum with 6 values
  print('TargetPlatform enum values:');
  for (final platform in TargetPlatform.values) {
    print('  ${platform.name}: index=${platform.index}');
  }
  print('TargetPlatform has ${TargetPlatform.values.length} values');

  // Test first and last
  final first = TargetPlatform.values.first;
  final last = TargetPlatform.values.last;
  print('\nFirst value: $first (index ${first.index})');
  print('Last value: $last (index ${last.index})');

  // Test each platform
  print('\nTesting TargetPlatform.android:');
  final android = TargetPlatform.android;
  print('  name: ${android.name}');
  print('  index: ${android.index}');
  print('  toString: $android');

  print('\nTesting TargetPlatform.fuchsia:');
  final fuchsia = TargetPlatform.fuchsia;
  print('  name: ${fuchsia.name}');
  print('  index: ${fuchsia.index}');

  print('\nTesting TargetPlatform.iOS:');
  final iOS = TargetPlatform.iOS;
  print('  name: ${iOS.name}');
  print('  index: ${iOS.index}');

  print('\nTesting TargetPlatform.linux:');
  final linux = TargetPlatform.linux;
  print('  name: ${linux.name}');
  print('  index: ${linux.index}');

  print('\nTesting TargetPlatform.macOS:');
  final macOS = TargetPlatform.macOS;
  print('  name: ${macOS.name}');
  print('  index: ${macOS.index}');

  print('\nTesting TargetPlatform.windows:');
  final windows = TargetPlatform.windows;
  print('  name: ${windows.name}');
  print('  index: ${windows.index}');

  // Test defaultTargetPlatform
  print('\ndefaultTargetPlatform: $defaultTargetPlatform');
  print('defaultTargetPlatform name: ${defaultTargetPlatform.name}');

  // Test equality
  print('\nEquality tests:');
  print('android == android: ${android == android}');
  print('android == iOS: ${android == iOS}');

  // Platform categorization
  print('\nPlatform categories:');
  final mobile = [TargetPlatform.android, TargetPlatform.iOS];
  final desktop = [TargetPlatform.linux, TargetPlatform.macOS, TargetPlatform.windows];
  print('Mobile platforms: ${mobile.map((p) => p.name).join(", ")}');
  print('Desktop platforms: ${desktop.map((p) => p.name).join(", ")}');

  // Test debugDefaultTargetPlatformOverride
  print('\ndebugDefaultTargetPlatformOverride: $debugDefaultTargetPlatformOverride');

  // Test switch pattern
  String getPlatformType(TargetPlatform p) {
    switch (p) {
      case TargetPlatform.android:
      case TargetPlatform.iOS:
        return 'mobile';
      case TargetPlatform.linux:
      case TargetPlatform.macOS:
      case TargetPlatform.windows:
        return 'desktop';
      case TargetPlatform.fuchsia:
        return 'fuchsia';
    }
  }
  print('\nPlatform type for current: ${getPlatformType(defaultTargetPlatform)}');

  print('\n' + '=' * 50);
  print('TargetPlatform test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('TargetPlatform Tests', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      SizedBox(height: 8),
      Text('Values: ${TargetPlatform.values.length}'),
      Text('android, fuchsia, iOS, linux, macOS, windows'),
      Text('Current: $defaultTargetPlatform'),
    ],
  );
}
