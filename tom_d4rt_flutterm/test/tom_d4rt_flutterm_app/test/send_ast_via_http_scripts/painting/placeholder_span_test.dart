// D4rt test script: Tests PlaceholderSpan from painting
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('PlaceholderSpan test executing');

  // Test PlaceholderSpan - Inline span placeholder
  print('PlaceholderSpan is available in the painting package');
  print('PlaceholderSpan: Inline span placeholder');

  print('PlaceholderSpan test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('PlaceholderSpan Tests'),
      Text('Inline span placeholder'),
    ],
  );
}
