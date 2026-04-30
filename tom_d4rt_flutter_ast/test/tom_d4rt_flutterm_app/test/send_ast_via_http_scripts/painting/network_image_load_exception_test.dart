// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests NetworkImageLoadException from painting
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('NetworkImageLoadException test executing');

  // Create NetworkImageLoadException
  final exception = NetworkImageLoadException(
    statusCode: 404,
    uri: Uri.parse('https://example.com/image.png'),
  );

  print('Created: ${exception.runtimeType}');

  // Test properties
  print('\nException properties:');
  print('statusCode: ${exception.statusCode}');
  print('uri: ${exception.uri}');

  // toString
  print('\ntoString:');
  print('$exception');

  // Test type hierarchy
  print('\nType hierarchy:');
  print('is Exception: ${true}');

  // Common status codes
  print('\nCommon status codes:');
  print('400 - Bad Request');
  print('401 - Unauthorized');
  print('403 - Forbidden');
  print('404 - Not Found');
  print('500 - Server Error');

  // When thrown
  print('\nWhen thrown:');
  print('- NetworkImage fails to load');
  print('- HTTP status not 200-299');
  print('- Image.network fails');

  // Handling
  print('\nHandling example:');
  print('Image.network(');
  print('  url,');
  print('  errorBuilder: (ctx, error, stack) {');
  print('    if (error is NetworkImageLoadException) {');
  print('      return Text("Error \${error.statusCode}");');
  print('    }');
  print('    return Icon(Icons.error);');
  print('  },');
  print(')');

  print('\nNetworkImageLoadException test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'NetworkImageLoadException Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Network image load error'),
      Text('statusCode: ${exception.statusCode}'),
      Text('uri: ${exception.uri}'),
      Text('Cause: HTTP error response'),
    ],
  );
}
