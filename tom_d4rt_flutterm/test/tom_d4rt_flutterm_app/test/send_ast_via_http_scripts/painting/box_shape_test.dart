// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests BoxShape from painting
import 'package:flutter/painting.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('BoxShape test executing');
  print('=' * 50);

  // Enumerate all values
  print('\nBoxShape values:');
  for (final value in BoxShape.values) {
    print('  ${value.name}: index=${value.index}');
  }
  print('BoxShape has ${BoxShape.values.length} values');

  // First and last
  final first = BoxShape.values.first;
  final last = BoxShape.values.last;
  print('\nFirst: $first (${first.name}, index ${first.index})');
  print('Last: $last (${last.name}, index ${last.index})');

  // Specific values
  print('\nSpecific values:');
  print('rectangle: ${BoxShape.rectangle.name} (index ${BoxShape.rectangle.index})');
  print('  Default shape, can have rounded corners via BorderRadius');
  print('  Combined with borderRadius for rounded rectangles');
  print('circle: ${BoxShape.circle.name} (index ${BoxShape.circle.index})');
  print('  Draws a circle inscribed in the rectangular bounds');
  print('  Cannot be combined with borderRadius (assertion error)');

  // BoxDecoration integration
  print('\nBoxDecoration integration:');
  final rectDecor = BoxDecoration(
    shape: BoxShape.rectangle,
    color: Colors.blue,
    borderRadius: BorderRadius.circular(8.0),
  );
  print('  Rectangle: shape=${rectDecor.shape}, borderRadius=${rectDecor.borderRadius}');

  final circleDecor = BoxDecoration(
    shape: BoxShape.circle,
    color: Colors.red,
  );
  print('  Circle: shape=${circleDecor.shape}');

  // Container usage
  print('\nContainer usage:');
  print('  Container(decoration: BoxDecoration(shape: BoxShape.rectangle))');
  print('  Container(decoration: BoxDecoration(shape: BoxShape.circle))');
  print('  Circle ignores width/height difference — uses the smaller dimension');

  // CircleAvatar uses circle shape internally
  print('\nCircleAvatar relation:');
  print('  CircleAvatar internally uses BoxShape.circle for clipping');
  print('  Equivalent to ClipOval around a Container');

  // Shape constraints
  print('\nShape constraints:');
  print('  rectangle + borderRadius: OK');
  print('  rectangle + no borderRadius: OK (sharp corners)');
  print('  circle + borderRadius: NOT OK (assertion fails)');
  print('  circle + no borderRadius: OK');

  // Equality tests
  print('\nEquality tests:');
  print('rectangle == rectangle: ${BoxShape.rectangle == BoxShape.rectangle}');
  print('rectangle == circle: ${BoxShape.rectangle == BoxShape.circle}');
  print('identical: ${identical(BoxShape.rectangle, BoxShape.values[0])}');

  // Type checks
  print('\nType checks:');
  print('runtimeType: ${first.runtimeType}');
  print('is BoxShape: ${first is BoxShape}');
  print('is Enum: ${first is Enum}');

  // String representations
  print('\nString representations:');
  for (final value in BoxShape.values) {
    print('  toString: $value, name: ${value.name}');
  }

  print('\n' + '=' * 50);
  print('BoxShape test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'BoxShape Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Values: ${BoxShape.values.length}'),
      for (final v in BoxShape.values)
        Text('  ${v.name} (${v.index})'),
      Text('BoxDecoration: rectangle or circle shape'),
    ],
  );
}
