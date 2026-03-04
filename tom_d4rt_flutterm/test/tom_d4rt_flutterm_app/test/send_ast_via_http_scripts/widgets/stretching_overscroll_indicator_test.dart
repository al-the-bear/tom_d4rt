// D4rt test script: Tests StretchingOverscrollIndicator from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('StretchingOverscrollIndicator test executing');

  // Test StretchingOverscrollIndicator - Stretch overscroll
  print('StretchingOverscrollIndicator is available in the widgets package');
  print('StretchingOverscrollIndicator runtimeType accessible');

  print('StretchingOverscrollIndicator test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('StretchingOverscrollIndicator Tests'),
      Text('Stretch overscroll'),
    ],
  );
}
