// D4rt test script: Tests BaseRangeSliderTrackShape from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('BaseRangeSliderTrackShape test executing');
  print('=' * 50);

  // BaseRangeSliderTrackShape mixin for range sliders
  print('\nBaseRangeSliderTrackShape:');
  print('Mixin providing base range slider track calculations');
  print('Common methods for RangeSliderTrackShape implementations');

  // Purpose
  print('\nPurpose:');
  print('- Calculate track rect for RangeSlider');
  print('- Handle two thumb positions');
  print('- Common range track positioning logic');

  // getPreferredRect method
  print('\nProvides getPreferredRect method:');
  print('Rect getPreferredRect({');
  print('  required RenderBox parentBox,');
  print('  Offset offset = Offset.zero,');
  print('  required SliderThemeData sliderTheme,');
  print('  bool isEnabled = false,');
  print('  bool isDiscrete = false,');
  print('})');
  print('\nReturns preferred track rectangle');

  // RangeSlider vs Slider
  print('\nRangeSlider vs Slider:');
  print('');
  print('Slider:');
  print('  - Single thumb');
  print('  - One value');
  print('  - SliderTrackShape');
  print('');
  print('RangeSlider:');
  print('  - Two thumbs (start/end)');
  print('  - RangeValues (start, end)');
  print('  - RangeSliderTrackShape');

  // RangeSliderTrackShape paint
  print('\nRangeSliderTrackShape.paint:');
  print('void paint(');
  print('  PaintingContext context,');
  print('  Offset offset, {');
  print('  required RenderBox parentBox,');
  print('  required SliderThemeData sliderTheme,');
  print('  required Animation<double> enableAnimation,');
  print('  required Offset startThumbCenter,');
  print('  required Offset endThumbCenter,');
  print('  bool isEnabled = false,');
  print('  bool isDiscrete = false,');
  print('  required TextDirection textDirection,');
  print('})');

  // Used by
  print('\nUsed by track shapes:');
  print('- RectangularRangeSliderTrackShape');
  print('- RoundedRectRangeSliderTrackShape');

  // Type hierarchy
  print('\nType hierarchy:');
  print('BaseRangeSliderTrackShape (mixin)');
  print('  \u2514\u2500 Mixed into RangeSliderTrackShape classes');

  // Explain purpose
  print('\nBaseRangeSliderTrackShape purpose:');
  print('- Mixin for range track calculations');
  print('- getPreferredRect method');
  print('- Two-thumb slider support');
  print('- Used by range track shapes');
  print('- Simplifies custom range tracks');

  print('\n' + '=' * 50);
  print('BaseRangeSliderTrackShape test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'BaseRangeSliderTrackShape Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Type: mixin'),
      Text('Method: getPreferredRect'),
      Text('For: RangeSliderTrackShape'),
      Text('Purpose: Range track calculations'),
    ],
  );
}
