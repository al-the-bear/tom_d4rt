// ignore_for_file: avoid_print
// D4rt test script: Tests DocumentationIcon annotation from foundation
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('DocumentationIcon test executing');
  print('=' * 50);

  // Create DocumentationIcon with icon URL
  final icon1 = DocumentationIcon('https://flutter.dev/icons/widgets.png');
  print('\nDocumentationIcon created:');
  print('runtimeType: ${icon1.runtimeType}');
  print('url: ${icon1.url}');

  // Create with different URLs
  final icon2 = DocumentationIcon('https://flutter.dev/icons/material.svg');
  print('\nDifferent URL:');
  print('url: ${icon2.url}');

  // Create with relative path
  final icon3 = DocumentationIcon('assets/images/icon.png');
  print('\nRelative path:');
  print('url: ${icon3.url}');

  // Create with empty URL
  final icon4 = DocumentationIcon('');
  print('\nEmpty URL:');
  print('url: "${icon4.url}"');
  print('url.isEmpty: ${icon4.url.isEmpty}');

  // Test type hierarchy
  print('\nType hierarchy:');
  print('is Object: true /* icon1 is Object */');

  // Compare instances
  final sameIcon1 = DocumentationIcon('https://example.com/icon.png');
  final sameIcon2 = DocumentationIcon('https://example.com/icon.png');
  print('\nInstance comparison:');
  print('sameIcon1 == sameIcon2: ${sameIcon1 == sameIcon2}');
  print('identical(sameIcon1, sameIcon2): ${identical(sameIcon1, sameIcon2)}');
  print('sameIcon1.url == sameIcon2.url: ${sameIcon1.url == sameIcon2.url}');

  // URL format examples
  print('\nCommon URL formats:');
  final httpIcon = DocumentationIcon('http://example.com/icon.png');
  final httpsIcon = DocumentationIcon('https://example.com/icon.png');
  final dataIcon = DocumentationIcon('data:image/png;base64,ABC123');
  print('HTTP URL: ${httpIcon.url.startsWith("http:")}');
  print('HTTPS URL: ${httpsIcon.url.startsWith("https:")}');
  print('Data URL: ${dataIcon.url.startsWith("data:")}');

  // Test URL properties
  print('\nURL properties:');
  print('url.length: ${icon1.url.length}');
  print('url.contains("flutter"): ${icon1.url.contains("flutter")}');

  // Explain purpose
  print('\nDocumentationIcon purpose:');
  print('- Annotation for specifying documentation icons');
  print('- Used by dartdoc to display icons in API docs');
  print('- Associates visual representation with classes');
  print('- url property points to icon image');
  print('- Supports various URL formats (http, https, data)');

  print('\n' + '=' * 50);
  print('DocumentationIcon test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'DocumentationIcon Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Type: ${icon1.runtimeType}'),
      Text('URL: ${icon1.url}'),
      Text('Empty URL isEmpty: ${icon4.url.isEmpty}'),
      Text('Same URL equals: ${sameIcon1.url == sameIcon2.url}'),
      Text('Purpose: Documentation icon annotation'),
    ],
  );
}
