// D4rt test script: Tests MissingPluginException from services
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('MissingPluginException test executing');

  // Create MissingPluginException
  final exception = MissingPluginException(
    'No implementation for channel: my_channel',
  );

  print('Created: ${exception.runtimeType}');

  // Test message
  print('\nException message:');
  print('message: ${exception.message}');
  print('toString: $exception');

  // Test type hierarchy
  print('\nType hierarchy:');
  print('is Exception: ${exception is Exception}');

  // Without message
  print('\nWithout message:');
  final noMsg = MissingPluginException();
  print('message: ${noMsg.message}');
  print('toString: $noMsg');

  // Explain when this occurs
  print('\nWhen this occurs:');
  print('- MethodChannel.invokeMethod() called');
  print('- No handler registered on platform side');
  print('- Native code missing channel handler');
  print('- Plugin not properly initialized');

  // Common causes
  print('\nCommon causes:');
  print('1. Plugin not added to pubspec.yaml');
  print('2. Native code not linked properly');
  print('3. Wrong channel name');
  print('4. Platform not supported');

  // How to fix
  print('\nHow to fix:');
  print('- Verify plugin is in dependencies');
  print('- Run: flutter clean && flutter pub get');
  print('- Check native code registration');
  print('- Use try-catch for graceful handling');

  print('\nMissingPluginException test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'MissingPluginException Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Plugin not found error'),
      Text('message: ${exception.message ?? "null"}'),
      Text('Cause: No channel handler'),
      Text('Fix: Check plugin setup'),
    ],
  );
}
