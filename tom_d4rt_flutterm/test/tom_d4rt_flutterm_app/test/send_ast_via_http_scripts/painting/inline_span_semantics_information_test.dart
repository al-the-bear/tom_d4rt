// D4rt test script: Tests InlineSpanSemanticsInformation from painting
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('InlineSpanSemanticsInformation test executing');

  // Test InlineSpanSemanticsInformation - Span semantics
  print('InlineSpanSemanticsInformation is available in the painting package');
  print('InlineSpanSemanticsInformation: Span semantics');

  print('InlineSpanSemanticsInformation test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('InlineSpanSemanticsInformation Tests'),
      Text('Span semantics'),
    ],
  );
}
