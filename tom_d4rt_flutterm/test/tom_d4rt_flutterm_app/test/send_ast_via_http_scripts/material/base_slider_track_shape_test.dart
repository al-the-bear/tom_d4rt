// D4rt test script: Tests BaseSliderTrackShape from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('BaseSliderTrackShape test executing');
  print('=' * 50);

  // BaseSliderTrackShape mixin for slider tracks
  print('\nBaseSliderTrackShape:');
  print('Mixin providing base slider track calculations');
  print('Common methods for SliderTrackShape implementations');

  // Purpose
  print('\nPurpose:');
  print('- Calculate track rect');
  print('- Handle overlay/value indicator');
  print('- Common track positioning logic');

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

  // Used by
  print('\nUsed by track shapes:');
  print('- RectangularSliderTrackShape');
  print('- RoundedRectSliderTrackShape');
  print('- Custom SliderTrackShape implementations');

  // SliderTrackShape paint method
  print('\nSliderTrackShape.paint:');
  print('void paint(');
  print('  PaintingContext context,');
  print('  Offset offset, {');
  print('  required RenderBox parentBox,');
  print('  required SliderThemeData sliderTheme,');
  print('  required Animation<double> enableAnimation,');
  print('  required TextDirection textDirection,');
  print('  required Offset thumbCenter,');
  print('  Offset? secondaryOffset,');
  print('  bool isDiscrete = false,');
  print('  bool isEnabled = false,');
  print('})');

  // Example custom track
  print('\nCustom track example:');
  print('class MyTrackShape extends SliderTrackShape');
  print('    with BaseSliderTrackShape {');
  print('  @override');
  print('  void paint(...) {');
  print('    final rect = getPreferredRect(...);');
  print('    // Custom paint logic');
  print('  }');
  print('}');

  // Type hierarchy
  print('\nType hierarchy:');
  print('BaseSliderTrackShape (mixin)');
  print('  \u2514\u2500 Mixed into SliderTrackShape classes');

  // Explain purpose
  print('\nBaseSliderTrackShape purpose:');
  print('- Mixin for track calculations');
  print('- getPreferredRect method');
  print('- Common slider track logic');
  print('- Used by track shapes');
  print('- Simplifies custom tracks');

  print('\n' + '=' * 50);
  print('BaseSliderTrackShape test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'BaseSliderTrackShape Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Type: mixin'),
      Text('Method: getPreferredRect'),
      Text('For: SliderTrackShape'),
      Text('Purpose: Track calculations'),
    ],
  );
}
