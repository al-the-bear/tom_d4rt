// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests BoxFit from painting
import 'package:flutter/painting.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('BoxFit test executing');
  print('=' * 50);

  // Enumerate all values
  print('\nBoxFit values:');
  for (final value in BoxFit.values) {
    print('  ${value.name}: index=${value.index}');
  }
  print('BoxFit has ${BoxFit.values.length} values');

  // First and last
  final first = BoxFit.values.first;
  final last = BoxFit.values.last;
  print('\nFirst: $first (${first.name}, index ${first.index})');
  print('Last: $last (${last.name}, index ${last.index})');

  // Specific values with behavior description
  print('\nSpecific values:');
  print('fill: ${BoxFit.fill.name}');
  print('  Stretches to fill the box completely, may distort aspect ratio');
  print('contain: ${BoxFit.contain.name}');
  print('  Scales to fit inside the box, maintains aspect ratio, may leave empty space');
  print('cover: ${BoxFit.cover.name}');
  print('  Scales to cover the entire box, maintains aspect ratio, may clip content');
  print('fitWidth: ${BoxFit.fitWidth.name}');
  print('  Scales to match the width of the box, may overflow vertically');
  print('fitHeight: ${BoxFit.fitHeight.name}');
  print('  Scales to match the height of the box, may overflow horizontally');
  print('none: ${BoxFit.none.name}');
  print('  No scaling, centers the content at its natural size');
  print('scaleDown: ${BoxFit.scaleDown.name}');
  print('  Like contain, but never scales up, only scales down if needed');

  // CSS equivalent comparison
  print('\nCSS object-fit equivalents:');
  print('  fill -> object-fit: fill');
  print('  contain -> object-fit: contain');
  print('  cover -> object-fit: cover');
  print('  none -> object-fit: none');
  print('  scaleDown -> object-fit: scale-down');

  // Image widget usage
  print('\nImage widget usage:');
  for (final fit in BoxFit.values) {
    print('  Image.asset("img.png", fit: BoxFit.${fit.name})');
  }

  // FittedBox usage
  print('\nFittedBox usage:');
  print('  FittedBox(fit: BoxFit.contain) — default');
  print('  FittedBox(fit: BoxFit.scaleDown) — never enlarges');

  // Equality tests
  print('\nEquality tests:');
  print('fill == fill: ${BoxFit.fill == BoxFit.fill}');
  print('fill == cover: ${BoxFit.fill == BoxFit.cover}');
  print('identical: ${identical(BoxFit.fill, BoxFit.values[0])}');

  // Type checks
  print('\nType checks:');
  print('runtimeType: ${first.runtimeType}');
  print('is BoxFit: ${first is BoxFit}');
  print('is Enum: ${first is Enum}');

  // String representations
  print('\nString representations:');
  for (final value in BoxFit.values) {
    print('  toString: $value, name: ${value.name}');
  }

  print('\n' + '=' * 50);
  print('BoxFit test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'BoxFit Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Values: ${BoxFit.values.length}'),
      for (final v in BoxFit.values)
        Text('  ${v.name} (${v.index})'),
      Text('Image/FittedBox: scaling strategy'),
    ],
  );
}
