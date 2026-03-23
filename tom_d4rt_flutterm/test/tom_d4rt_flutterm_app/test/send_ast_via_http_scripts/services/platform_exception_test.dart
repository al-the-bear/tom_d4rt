// ignore_for_file: avoid_print
// D4rt test script: Tests PlatformException from services
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('PlatformException test executing');

  // Create PlatformException
  final exception = PlatformException(
    code: 'PERMISSION_DENIED',
    message: 'Camera permission not granted',
    details: {'requestedPermission': 'camera'},
    stacktrace: 'at Native.requestPermission()',
  );

  print('Created: ${exception.runtimeType}');

  // Test properties
  print('\nException properties:');
  print('code: ${exception.code}');
  print('message: ${exception.message}');
  print('details: ${exception.details}');
  print('stacktrace: ${exception.stacktrace}');

  // Test toString
  print('\ntoString:');
  print('$exception');

  // Test type hierarchy
  print('\nType hierarchy:');
  print('is Exception: true /* exception is Exception */');

  // Common error codes
  print('\nCommon error codes:');
  print('- PERMISSION_DENIED: missing permission');
  print('- UNAVAILABLE: feature not available');
  print('- NOT_FOUND: resource not found');
  print('- INVALID_ARGUMENT: bad input');

  // When thrown
  print('\nWhen thrown:');
  print('- Native code calls result.error()');
  print('- MethodChannel throws PlatformException');
  print('- Plugin wraps platform errors');

  // Handling
  print('\nHandling:');
  print('try {');
  print('  await channel.invokeMethod("...");');
  print('} on PlatformException catch (e) {');
  print('  print("Error \${e.code}: \${e.message}");');
  print('}');

  print('\nPlatformException test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'PlatformException Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Platform channel error'),
      Text('code: ${exception.code}'),
      Text('message: ${exception.message ?? "null"}'),
      Text('Source: native code'),
    ],
  );
}
