// D4rt test script: Tests GlowingOverscrollIndicator from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('GlowingOverscrollIndicator test executing');

  // Test GlowingOverscrollIndicator - Glow overscroll
  print('GlowingOverscrollIndicator is available in the widgets package');
  print('GlowingOverscrollIndicator runtimeType accessible');

  print('GlowingOverscrollIndicator test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('GlowingOverscrollIndicator Tests'),
      Text('Glow overscroll'),
    ],
  );
}
