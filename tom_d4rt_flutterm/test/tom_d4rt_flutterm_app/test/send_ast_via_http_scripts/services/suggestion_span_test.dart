// D4rt test script: Tests SuggestionSpan from services
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('SuggestionSpan test executing');

  // Test SuggestionSpan - Suggestion span
  print('SuggestionSpan is available in the services package');
  print('SuggestionSpan: Suggestion span');

  print('SuggestionSpan test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('SuggestionSpan Tests'),
      Text('Suggestion span'),
    ],
  );
}
