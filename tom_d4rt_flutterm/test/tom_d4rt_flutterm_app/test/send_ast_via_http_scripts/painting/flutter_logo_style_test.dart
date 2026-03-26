// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests FlutterLogoStyle from painting
import 'package:flutter/painting.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('FlutterLogoStyle test executing');
  print('=' * 50);

  // Enumerate all values
  print('\nFlutterLogoStyle values:');
  for (final value in FlutterLogoStyle.values) {
    print('  ${value.name}: index=${value.index}');
  }
  print('FlutterLogoStyle has ${FlutterLogoStyle.values.length} values');

  // First and last
  final first = FlutterLogoStyle.values.first;
  final last = FlutterLogoStyle.values.last;
  print('\nFirst: $first (${first.name}, index ${first.index})');
  print('Last: $last (${last.name}, index ${last.index})');

  // Specific values
  print('\nSpecific values:');
  print('markOnly: ${FlutterLogoStyle.markOnly.name} (index ${FlutterLogoStyle.markOnly.index})');
  print('  Shows only the Flutter logo mark (the bird icon)');
  print('  No text label is displayed alongside the mark');
  print('horizontal: ${FlutterLogoStyle.horizontal.name} (index ${FlutterLogoStyle.horizontal.index})');
  print('  Shows the mark with "Flutter" text to the right');
  print('  Wider layout, good for headers and app bars');
  print('stacked: ${FlutterLogoStyle.stacked.name} (index ${FlutterLogoStyle.stacked.index})');
  print('  Shows the mark with "Flutter" text below');
  print('  Taller layout, good for splash screens');

  // FlutterLogoDecoration integration
  print('\nFlutterLogoDecoration integration:');
  final markDecor = FlutterLogoDecoration(style: FlutterLogoStyle.markOnly);
  print('  markOnly: style=${markDecor.style}');
  final horizDecor = FlutterLogoDecoration(style: FlutterLogoStyle.horizontal);
  print('  horizontal: style=${horizDecor.style}');
  final stackDecor = FlutterLogoDecoration(style: FlutterLogoStyle.stacked);
  print('  stacked: style=${stackDecor.style}');

  // FlutterLogo widget usage
  print('\nFlutterLogo widget usage:');
  print('  FlutterLogo(style: FlutterLogoStyle.markOnly)');
  print('  FlutterLogo(style: FlutterLogoStyle.horizontal)');
  print('  FlutterLogo(style: FlutterLogoStyle.stacked)');
  print('  Default style: FlutterLogoStyle.markOnly');

  // Size recommendations
  print('\nSize recommendations:');
  print('  markOnly: works well at any size');
  print('  horizontal: needs wider container for text');
  print('  stacked: needs taller container for text below');

  // Equality tests
  print('\nEquality tests:');
  print('markOnly == markOnly: ${FlutterLogoStyle.markOnly == FlutterLogoStyle.markOnly}');
  print('markOnly == stacked: ${FlutterLogoStyle.markOnly == FlutterLogoStyle.stacked}');
  print('identical: ${identical(FlutterLogoStyle.markOnly, FlutterLogoStyle.values[0])}');

  // Type checks
  print('\nType checks:');
  print('runtimeType: ${first.runtimeType}');
  print('is FlutterLogoStyle: ${first is FlutterLogoStyle}');
  print('is Enum: ${first is Enum}');

  // String representations
  print('\nString representations:');
  for (final value in FlutterLogoStyle.values) {
    print('  toString: $value, name: ${value.name}');
  }

  // Animated transitions
  print('\nAnimated transitions:');
  print('  FlutterLogoDecoration supports lerp between styles');
  print('  Animating from markOnly to horizontal shows text appearing');
  print('  Animating from horizontal to stacked repositions text');

  print('\n' + '=' * 50);
  print('FlutterLogoStyle test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'FlutterLogoStyle Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Values: ${FlutterLogoStyle.values.length}'),
      for (final v in FlutterLogoStyle.values)
        Text('  ${v.name} (${v.index})'),
      Text('FlutterLogo: controls logo layout'),
    ],
  );
}
