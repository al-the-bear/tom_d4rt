// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests WebHtmlElementStrategy from painting
import 'package:flutter/painting.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('WebHtmlElementStrategy test executing');
  print('=' * 50);

  // WebHtmlElementStrategy is an enum controlling how NetworkImage
  // fetches images on web platforms
  print('\nWebHtmlElementStrategy is an enum');
  print('Purpose: Controls image loading strategy on Flutter web');
  print('Used by: NetworkImage constructor');

  // Enumerate all values
  print('\nWebHtmlElementStrategy values:');
  for (final value in WebHtmlElementStrategy.values) {
    print('  ${value.name}: index=${value.index}');
  }
  print('WebHtmlElementStrategy has ${WebHtmlElementStrategy.values.length} values');

  // First and last
  final first = WebHtmlElementStrategy.values.first;
  final last = WebHtmlElementStrategy.values.last;
  print('\nFirst: $first (index ${first.index})');
  print('Last: $last (index ${last.index})');

  // Test individual values with their meanings
  print('\nValue details:');

  // never - only use byte fetching, never HTML elements
  final never = WebHtmlElementStrategy.never;
  print('never: $never');
  print('  index: ${never.index}');
  print('  Fetches bytes only, reports errors on failure');

  // fallback - prefer bytes, fall back to HTML elements
  final fallback = WebHtmlElementStrategy.fallback;
  print('fallback: $fallback');
  print('  index: ${fallback.index}');
  print('  Uses HTML elements only if headers empty and fetch fails');

  // prefer - prefer HTML elements, fall back to byte fetching
  final prefer = WebHtmlElementStrategy.prefer;
  print('prefer: $prefer');
  print('  index: ${prefer.index}');
  print('  Fetches bytes only when headers are not empty');

  // Equality and identity checks
  print('\nEquality checks:');
  print('never == never: ${never == WebHtmlElementStrategy.never}');
  print('never == fallback: ${never == fallback}');
  print('fallback == prefer: ${fallback == prefer}');

  // Usage context
  print('\nUsage context:');
  print('NetworkImage(url,');
  print('  webHtmlElementStrategy: WebHtmlElementStrategy.never,');
  print(');');
  print('Default strategy is WebHtmlElementStrategy.never');

  // Web platform considerations
  print('\nWeb platform notes:');
  print('- HTML elements do not support custom headers');
  print('- Byte fetching works on all platforms');
  print('- HTML element strategy is web-only');
  print('- On non-web platforms, this enum is ignored');

  // Test values list indexing
  print('\nIndex lookup:');
  for (var i = 0; i < WebHtmlElementStrategy.values.length; i++) {
    print('  values[$i] = ${WebHtmlElementStrategy.values[i]}');
  }

  print('\n${'=' * 50}');
  print('WebHtmlElementStrategy test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'WebHtmlElementStrategy Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Values: ${WebHtmlElementStrategy.values.length}'),
      Text('never: index ${never.index}'),
      Text('fallback: index ${fallback.index}'),
      Text('prefer: index ${prefer.index}'),
    ],
  );
}
