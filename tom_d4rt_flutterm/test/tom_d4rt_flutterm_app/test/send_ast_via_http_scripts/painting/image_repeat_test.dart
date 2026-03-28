// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests ImageRepeat from painting
import 'package:flutter/painting.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('ImageRepeat test executing');
  print('=' * 50);

  // ImageRepeat enum overview
  print('ImageRepeat enum overview:');
  print('  - How to tile an image');
  print('  - Used in DecorationImage');
  print('  - 4 values: repeat, repeatX, repeatY, noRepeat');

  // Enumerate all values
  print('\nImageRepeat values:');
  for (final value in ImageRepeat.values) {
    print('  ${value.name}: index=${value.index}');
  }
  print('ImageRepeat has ${ImageRepeat.values.length} values');

  // Test repeat
  print('\nTest ImageRepeat.repeat:');
  final repeat = ImageRepeat.repeat;
  print('  Name: ${repeat.name}');
  print('  Tiles: Both X and Y directions');

  // Test repeatX
  print('\nTest ImageRepeat.repeatX:');
  final repeatX = ImageRepeat.repeatX;
  print('  Name: ${repeatX.name}');
  print('  Tiles: Only horizontal');

  // Test repeatY
  print('\nTest ImageRepeat.repeatY:');
  final repeatY = ImageRepeat.repeatY;
  print('  Name: ${repeatY.name}');
  print('  Tiles: Only vertical');

  // Test noRepeat
  print('\nTest ImageRepeat.noRepeat:');
  final noRepeat = ImageRepeat.noRepeat;
  print('  Name: ${noRepeat.name}');
  print('  Tiles: No tiling');

  // First and last
  print('\nFirst and last:');
  print('  First: ${ImageRepeat.values.first}');
  print('  Last: ${ImageRepeat.values.last}');

  // Usage context
  print('\nUsage context:');
  print('  DecorationImage.repeat');
  print('  paintImage function');

  // Common use cases
  print('\nCommon use cases:');
  print('  repeat: Pattern backgrounds');
  print('  repeatX: Horizontal stripes');
  print('  repeatY: Vertical stripes');
  print('  noRepeat: Single centered image');

  // Switch pattern
  print('\nSwitch pattern:');
  final mode = ImageRepeat.repeat;
  switch (mode) {
    case ImageRepeat.repeat:
      print('  Tiling in both directions');
      break;
    case ImageRepeat.repeatX:
      print('  Tiling horizontally');
      break;
    case ImageRepeat.repeatY:
      print('  Tiling vertically');
      break;
    case ImageRepeat.noRepeat:
      print('  No tiling');
      break;
  }

  // Comparison
  print('\nComparison:');
  print('  repeat == repeat: ${ImageRepeat.repeat == ImageRepeat.repeat}');
  print('  repeat == noRepeat: ${ImageRepeat.repeat == ImageRepeat.noRepeat}');

  print('\n' + '=' * 50);
  print('ImageRepeat test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('ImageRepeat Tests', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      SizedBox(height: 8),
      Text('Type: Enum'),
      Text('Values: repeat, repeatX, repeatY, noRepeat'),
      Text('Purpose: Image tiling'),
    ],
  );
}
