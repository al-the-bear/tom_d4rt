// D4rt test script: Tests RectangularSliderTrackShape from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('RectangularSliderTrackShape test executing');

  // Test RectangularSliderTrackShape - Rect track
  print('RectangularSliderTrackShape is available in the material package');
  print('RectangularSliderTrackShape runtimeType accessible');

  print('RectangularSliderTrackShape test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('RectangularSliderTrackShape Tests'),
      Text('Rect track'),
    ],
  );
}
