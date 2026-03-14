// D4rt test script: Tests FlutterVersion from services
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('FlutterVersion test executing');
  print('=' * 50);

  // Create FlutterVersion with version components
  final version = FlutterVersion(
    frameworkRevision: 'abc123',
    channel: 'stable',
  );
  print('\nFlutterVersion created:');
  print('runtimeType: ${version.runtimeType}');
  print('frameworkRevision: ${version.frameworkRevision}');
  print('channel: ${version.channel}');

  // Create for different channels
  print('\nDifferent channels:');
  final stable = FlutterVersion(
    frameworkRevision: 'stable123',
    channel: 'stable',
  );
  final beta = FlutterVersion(frameworkRevision: 'beta456', channel: 'beta');
  final dev = FlutterVersion(frameworkRevision: 'dev789', channel: 'dev');
  final master = FlutterVersion(
    frameworkRevision: 'master000',
    channel: 'master',
  );
  print('Stable: ${stable.channel}');
  print('Beta: ${beta.channel}');
  print('Dev: ${dev.channel}');
  print('Master: ${master.channel}');

  // Test frameworkRevision patterns
  print('\nFramework revision patterns:');
  print('Git commit hash: ${version.frameworkRevision}');
  print('Stable revision: ${stable.frameworkRevision}');

  // Test type hierarchy
  print('\nType hierarchy:');
  print('is Object: ${version is Object}');

  // Channel stability comparison
  print('\nChannel stability order:');
  print('1. stable - Most stable, production ready');
  print('2. beta - Pre-release testing');
  print('3. dev - Development builds');
  print('4. master - Bleeding edge');

  // Compare versions
  print('\nVersion comparison:');
  final v1 = FlutterVersion(frameworkRevision: 'rev1', channel: 'stable');
  final v2 = FlutterVersion(frameworkRevision: 'rev2', channel: 'stable');
  print('v1 == v2: ${v1 == v2}');
  print('Same channel: ${v1.channel == v2.channel}');
  print('Different revision: ${v1.frameworkRevision != v2.frameworkRevision}');

  // Real revision format
  print('\nReal revision format example:');
  final realVersion = FlutterVersion(
    frameworkRevision: 'f468f3366c26a5092eb964a230ce7892fda8f2f8',
    channel: 'stable',
  );
  print('Full hash length: ${realVersion.frameworkRevision.length}');
  print('Short hash: ${realVersion.frameworkRevision.substring(0, 7)}');

  // Explain purpose
  print('\nFlutterVersion purpose:');
  print('- Represents Flutter SDK version information');
  print('- frameworkRevision: Git commit hash');
  print('- channel: stable/beta/dev/master');
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
      Text('Type: ${version.runtimeType}'),
      Text('channel: ${version.channel}'),
      Text('revision: ${version.frameworkRevision}'),
      Text('Purpose: SDK version information'),
    ],
  );
}
