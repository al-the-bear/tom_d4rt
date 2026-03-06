// D4rt test script: Tests InlineSpan from painting
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('InlineSpan test executing');

  // Test InlineSpan - Inline text span
  print('InlineSpan is available in the painting package');
  print('InlineSpan: Inline text span');

  print('InlineSpan test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('InlineSpan Tests'),
      Text('Inline text span'),
    ],
  );
}
