// D4rt test script: Tests RootIsolateToken from dart:ui
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('RootIsolateToken test executing');
  print('=' * 50);

  // RootIsolateToken for root isolate identification
  print('\nRootIsolateToken:');
  print('Token identifying the root isolate');
  print('Used for platform channel communication');

  // Get instance
  final token = ui.RootIsolateToken.instance;
  print('\nRootIsolateToken.instance:');
  print('token: $token');
  print('Type: ${token.runtimeType}');
  print('Is not null: ${token != null}');

  // Singleton behavior
  final token2 = ui.RootIsolateToken.instance;
  print('\nSingleton check:');
  print('Same instance: ${identical(token, token2)}');

  // When null
  print('\nWhen null:');
  print('- Not running in root isolate');
  print('- Running in spawned isolate');
  print('- Platform channels unavailable');

  // Use with BackgroundIsolateBinaryMessenger
  print('\nUse with BackgroundIsolateBinaryMessenger:');
  print('// In spawned isolate:');
  print('BackgroundIsolateBinaryMessenger.ensureInitialized(');
  print('  rootIsolateToken,');
  print(');');

  // Passing to isolate
  print('\nPassing to spawned isolate:');
  print('// In root isolate:');
  print('final token = RootIsolateToken.instance!;');
  print('Isolate.spawn(entryPoint, token);');
  print('');
  print('// In spawned isolate:');
  print('void entryPoint(RootIsolateToken token) {');
  print('  BackgroundIsolateBinaryMessenger');
  print('      .ensureInitialized(token);');
  print('  // Now can use platform channels');
  print('}');

  // Purpose
  print('\nPurpose:');
  print('- Enable platform channels in isolates');
  print('- Identify root isolate');
  print('- Background isolate communication');

  // Type hierarchy
  print('\nType hierarchy:');
  print('RootIsolateToken (class)');
  print('  \u2514\u2500 instance (static getter)');

  // Explain purpose
  print('\nRootIsolateToken purpose:');
  print('- Root isolate identification');
  print('- instance static getter');
  print('- Null in non-root isolates');
  print('- Platform channel enablement');
  print('- BackgroundIsolateBinaryMessenger');

  print('\n' + '=' * 50);
  print('RootIsolateToken test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'RootIsolateToken Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Instance: ${token != null ? "available" : "null"}'),
      Text('Singleton: ${identical(token, token2)}'),
      Text('Type: ${token.runtimeType}'),
      Text('Purpose: Root isolate ID'),
    ],
  );
}
