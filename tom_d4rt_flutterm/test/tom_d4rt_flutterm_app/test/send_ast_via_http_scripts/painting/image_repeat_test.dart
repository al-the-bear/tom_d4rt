// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests ImageRepeat from painting
import 'package:flutter/painting.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('ImageRepeat test executing');
  print('=' * 50);

  // Enumerate all values
  print('\nImageRepeat values:');
  for (final value in ImageRepeat.values) {
    print('  ${value.name}: index=${value.index}');
  }
  print('ImageRepeat has ${ImageRepeat.values.length} values');

  // First and last
  final first = ImageRepeat.values.first;
  final last = ImageRepeat.values.last;
  print('\nFirst: $first (${first.name}, index ${first.index})');
  print('Last: $last (${last.name}, index ${last.index})');

  // Specific values with tiling behavior
  print('\nSpecific values:');
  print('repeat: ${ImageRepeat.repeat.name} (index ${ImageRepeat.repeat.index})');
  print('  Tiles the image in both x and y directions');
  print('  Like CSS background-repeat: repeat');
  print('repeatX: ${ImageRepeat.repeatX.name} (index ${ImageRepeat.repeatX.index})');
  print('  Tiles only horizontally, single image vertically');
  print('  Like CSS background-repeat: repeat-x');
  print('repeatY: ${ImageRepeat.repeatY.name} (index ${ImageRepeat.repeatY.index})');
  print('  Tiles only vertically, single image horizontally');
  print('  Like CSS background-repeat: repeat-y');
  print('noRepeat: ${ImageRepeat.noRepeat.name} (index ${ImageRepeat.noRepeat.index})');
  print('  No tiling, single image is used');
  print('  Like CSS background-repeat: no-repeat');

  // DecorationImage integration
  print('\nDecorationImage integration:');
  print('  DecorationImage(image: ..., repeat: ImageRepeat.repeat)');
  print('  DecorationImage(image: ..., repeat: ImageRepeat.noRepeat) — default');
  print('  repeat is useful for pattern/texture backgrounds');
  print('  noRepeat is the default for single images');

  // CSS comparison
  print('\nCSS equivalents:');
  print('  repeat -> background-repeat: repeat');
  print('  repeatX -> background-repeat: repeat-x');
  print('  repeatY -> background-repeat: repeat-y');
  print('  noRepeat -> background-repeat: no-repeat');

  // Tiling geometry
  print('\nTiling geometry:');
  print('  repeat: fills entire area with tiles in a grid');
  print('  repeatX: creates a horizontal strip of tiles');
  print('  repeatY: creates a vertical strip of tiles');
  print('  noRepeat: positions one image using alignment');

  // Equality tests
  print('\nEquality tests:');
  print('repeat == repeat: ${ImageRepeat.repeat == ImageRepeat.repeat}');
  print('repeat == noRepeat: ${ImageRepeat.repeat == ImageRepeat.noRepeat}');
  print('identical: ${identical(ImageRepeat.repeat, ImageRepeat.values[0])}');

  // Type checks
  print('\nType checks:');
  print('runtimeType: ${first.runtimeType}');
  print('is ImageRepeat: ${first is ImageRepeat}');
  print('is Enum: ${first is Enum}');

  // String representations
  print('\nString representations:');
  for (final value in ImageRepeat.values) {
    print('  toString: $value, name: ${value.name}');
  }

  // Indexed iteration
  print('\nIndexed iteration:');
  for (var i = 0; i < ImageRepeat.values.length; i++) {
    final v = ImageRepeat.values[i];
    print('  [$i] ${v.name} (index=${v.index})');
  }

  print('\n' + '=' * 50);
  print('ImageRepeat test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'ImageRepeat Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Values: ${ImageRepeat.values.length}'),
      for (final v in ImageRepeat.values)
        Text('  ${v.name} (${v.index})'),
      Text('DecorationImage: controls image tiling'),
    ],
  );
}
