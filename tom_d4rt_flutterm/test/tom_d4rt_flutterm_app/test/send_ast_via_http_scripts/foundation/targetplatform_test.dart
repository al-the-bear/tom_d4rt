// D4rt test script: Tests TargetPlatform enum from foundation
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('TargetPlatform test executing');

  // ========== TARGETPLATFORM ENUM ==========
  print('--- TargetPlatform Tests ---');

  // Test all TargetPlatform enum values exist
  final android = TargetPlatform.android;
  print('TargetPlatform.android: $android');

  final fuchsia = TargetPlatform.fuchsia;
  print('TargetPlatform.fuchsia: $fuchsia');

  final iOS = TargetPlatform.iOS;
  print('TargetPlatform.iOS: $iOS');

  final linux = TargetPlatform.linux;
  print('TargetPlatform.linux: $linux');

  final macOS = TargetPlatform.macOS;
  print('TargetPlatform.macOS: $macOS');

  final windows = TargetPlatform.windows;
  print('TargetPlatform.windows: $windows');

  // Test enum values list
  final allValues = TargetPlatform.values;
  print('TargetPlatform.values count: ${allValues.length}');
  print('TargetPlatform.values: $allValues');

  // Test enum index
  print('android.index: ${android.index}');
  print('iOS.index: ${iOS.index}');

  // Test enum name
  print('android.name: ${android.name}');
  print('iOS.name: ${iOS.name}');
  print('linux.name: ${linux.name}');

  // Test defaultTargetPlatform
  final currentPlatform = defaultTargetPlatform;
  print('defaultTargetPlatform: $currentPlatform');

  // Test comparison
  print('android == android: ${android == TargetPlatform.android}');
  print('android == iOS: ${android == iOS}');

  // Test switch exhaustiveness
  String platformName;
  switch (currentPlatform) {
    case TargetPlatform.android:
      platformName = 'Android';
    case TargetPlatform.fuchsia:
      platformName = 'Fuchsia';
    case TargetPlatform.iOS:
      platformName = 'iOS';
    case TargetPlatform.linux:
      platformName = 'Linux';
    case TargetPlatform.macOS:
      platformName = 'macOS';
    case TargetPlatform.windows:
      platformName = 'Windows';
  }
  print('Current platform name: $platformName');

  print('All TargetPlatform tests passed');

  // ========== RETURN WIDGET ==========
  return MaterialApp(
    home: Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'TargetPlatform Test',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
            ),
            SizedBox(height: 8.0),
            Text('Current platform: $currentPlatform'),
            SizedBox(height: 4.0),
            Text('Total enum values: ${allValues.length}'),
            SizedBox(height: 4.0),
            ...allValues.map((p) => Text('  ${p.name}: index=${p.index}')),
          ],
        ),
      ),
    ),
  );
}
