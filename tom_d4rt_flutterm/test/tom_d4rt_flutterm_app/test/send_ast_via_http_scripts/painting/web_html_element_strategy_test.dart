// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests WebHtmlElementStrategy from painting
import 'package:flutter/painting.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('WebHtmlElementStrategy test executing');
  print('=' * 50);

  // WebHtmlElementStrategy enum overview
  print('WebHtmlElementStrategy enum overview:');
  print('  - HTML element strategy for web images');
  print('  - Web platform specific');
  print('  - 2 values: prefer, never');

  // Enumerate all values
  print('\nWebHtmlElementStrategy values:');
  for (final value in WebHtmlElementStrategy.values) {
    print('  ${value.name}: index=${value.index}');
  }
  print('WebHtmlElementStrategy has ${WebHtmlElementStrategy.values.length} values');

  // Test prefer
  print('\nTest WebHtmlElementStrategy.prefer:');
  final prefer = WebHtmlElementStrategy.prefer;
  print('  Name: ${prefer.name}');
  print('  Behavior: Use HTML img element when possible');
  print('  Benefits: Better performance, less memory');

  // Test never
  print('\nTest WebHtmlElementStrategy.never:');
  final never = WebHtmlElementStrategy.never;
  print('  Name: ${never.name}');
  print('  Behavior: Always decode in Dart');
  print('  Use case: Pixel manipulation needed');

  // First and last
  print('\nFirst and last:');
  print('  First: ${WebHtmlElementStrategy.values.first}');
  print('  Last: ${WebHtmlElementStrategy.values.last}');

  // Platform context
  print('\nPlatform context:');
  print('  Only affects web platform');
  print('  Ignored on mobile/desktop');

  // Usage context
  print('\nUsage context:');
  print('  NetworkImage.webHtmlElementStrategy');
  print('  Memory optimization on web');

  // Trade-offs
  print('\nTrade-offs:');
  print('  prefer: Fast load, limited manipulation');
  print('  never: Slow load, full control');

  // Switch pattern
  print('\nSwitch pattern:');
  final strategy = WebHtmlElementStrategy.prefer;
  switch (strategy) {
    case WebHtmlElementStrategy.prefer:
      print('  Using HTML element');
      break;
    case WebHtmlElementStrategy.fallback:
      print('  Prefer bytes, fallback to HTML');
      break;
    case WebHtmlElementStrategy.never:
      print('  Decoding in Dart');
      break;
  }

  // Comparison
  print('\nComparison:');
  print('  prefer == prefer: ${WebHtmlElementStrategy.prefer == WebHtmlElementStrategy.prefer}');
  print('  prefer == never: ${WebHtmlElementStrategy.prefer == WebHtmlElementStrategy.never}');

  print('\n' + '=' * 50);
  print('WebHtmlElementStrategy test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('WebHtmlElementStrategy Tests', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      SizedBox(height: 8),
      Text('Type: Enum'),
      Text('Values: never, fallback, prefer'),
      Text('Purpose: Web image strategy'),
    ],
  );
}
