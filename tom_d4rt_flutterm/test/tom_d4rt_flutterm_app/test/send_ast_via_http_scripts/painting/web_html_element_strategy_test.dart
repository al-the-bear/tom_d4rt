// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests WebHtmlElementStrategy from painting
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('WebHtmlElementStrategy test executing');

  // Enumerate all WebHtmlElementStrategy values
  print('WebHtmlElementStrategy values:');
  for (final value in WebHtmlElementStrategy.values) {
    print('  ${value.name}: $value');
  }
  print('WebHtmlElementStrategy has ${ WebHtmlElementStrategy.values.length} values');

  final first = WebHtmlElementStrategy.values.first;
  final last = WebHtmlElementStrategy.values.last;
  print('First: $first, Last: $last');
  print('First index: ${first.index}, Last index: ${last.index}');

  print('WebHtmlElementStrategy test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('WebHtmlElementStrategy Tests'),
      Text('Values: ${ WebHtmlElementStrategy.values.length}'),
      Text('First: $first'),
      Text('Last: $last'),
    ],
  );
}
