// ignore_for_file: avoid_print
// D4rt test script: Tests FlutterVersion from services
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('FlutterVersion test executing');
  print('=' * 50);

  // FlutterVersion provides static access to version info
  print('\nFlutterVersion static properties:');
  print('runtimeType: FlutterVersion');
  print('frameworkRevision: ${FlutterVersion.frameworkRevision}');
  print('channel: ${FlutterVersion.channel}');

  // Test framework revision format
  print('\nFramework revision format:');
  final revision = FlutterVersion.frameworkRevision;
  if (revision != null) {
    print('Full hash length: ${revision.length}');
    if (revision.length >= 7) {
      print('Short hash: ${revision.substring(0, 7)}');
    }
  } else {
    print('Framework revision: null (not available)');
  }

  // Test channel information
  print('\nChannel information:');
  final channel = FlutterVersion.channel;
  print('Current channel: $channel');

  // Channel stability reference
  print('\nChannel stability order:');
  print('1. stable - Most stable, production ready');
  print('2. beta - Pre-release testing');
  print('3. dev - Development builds');
  print('4. master - Bleeding edge');

  // Practical use cases
  print('\nPractical use cases:');
  print('- Check current Flutter version');
  print('- Log version in crash reports');
  print('- Conditional features by channel');
  print('- Debug version-specific issues');

  // Example conditional logic
  print('\nExample conditional logic:');
  print('if (FlutterVersion.channel == "stable") {');
  print('  // Use stable features');
  print('}');

  // Explain purpose
  print('\nFlutterVersion purpose:');
  print('- Represents Flutter SDK version information');
  print('- frameworkRevision: Git commit hash (static)');
  print('- channel: stable/beta/dev/master (static)');
  print('- Used for version tracking and debugging');
  print('- Helps identify SDK version in crash reports');

  print('\n' + '=' * 50);
  print('FlutterVersion test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'FlutterVersion Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Type: FlutterVersion (static API)'),
      Text('channel: ${FlutterVersion.channel}'),
      Text('revision: ${FlutterVersion.frameworkRevision ?? "null"}'),
      Text('Purpose: SDK version information'),
    ],
  );
}
