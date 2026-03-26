// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests BorderStyle from painting
import 'package:flutter/painting.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('BorderStyle test executing');
  print('=' * 50);

  // Enumerate all values
  print('\nBorderStyle values:');
  for (final value in BorderStyle.values) {
    print('  ${value.name}: index=${value.index}');
  }
  print('BorderStyle has ${BorderStyle.values.length} values');

  // First and last
  final first = BorderStyle.values.first;
  final last = BorderStyle.values.last;
  print('\nFirst: $first (${first.name}, index ${first.index})');
  print('Last: $last (${last.name}, index ${last.index})');

  // Specific values
  print('\nSpecific values:');
  print('none: ${BorderStyle.none.name} (index ${BorderStyle.none.index})');
  print('  No border is drawn; the border side is invisible');
  print('  Width is still considered for layout purposes');
  print('solid: ${BorderStyle.solid.name} (index ${BorderStyle.solid.index})');
  print('  A solid line is drawn as the border');
  print('  Most common border style in Material Design');

  // BorderSide integration
  print('\nBorderSide integration:');
  final noneBorder = BorderSide(style: BorderStyle.none, width: 2.0);
  final solidBorder = BorderSide(style: BorderStyle.solid, width: 2.0, color: Colors.blue);
  print('  none: style=${noneBorder.style}, width=${noneBorder.width}');
  print('  solid: style=${solidBorder.style}, width=${solidBorder.width}, color=${solidBorder.color}');

  // Default BorderSide
  final defaultSide = BorderSide();
  print('\nDefault BorderSide:');
  print('  style: ${defaultSide.style}');
  print('  width: ${defaultSide.width}');
  print('  color: ${defaultSide.color}');

  // BorderSide.none constant
  print('\nBorderSide.none:');
  print('  style: ${BorderSide.none.style}');
  print('  width: ${BorderSide.none.width}');

  // Border usage
  print('\nBorder usage:');
  final border = Border.all(width: 2.0, color: Colors.red, style: BorderStyle.solid);
  print('  Border.all solid: ${border.top.style}');
  final noBorder = Border.all(style: BorderStyle.none);
  print('  Border.all none: ${noBorder.top.style}');

  // Equality tests
  print('\nEquality tests:');
  print('none == none: ${BorderStyle.none == BorderStyle.none}');
  print('none == solid: ${BorderStyle.none == BorderStyle.solid}');
  print('identical: ${identical(BorderStyle.none, BorderStyle.values[0])}');

  // Type checks
  print('\nType checks:');
  print('runtimeType: ${first.runtimeType}');
  print('is BorderStyle: ${first is BorderStyle}');
  print('is Enum: ${first is Enum}');

  // String representations
  print('\nString representations:');
  for (final value in BorderStyle.values) {
    print('  toString: $value, name: ${value.name}');
  }

  // UnderlineInputBorder and OutlineInputBorder
  print('\nInputBorder integration:');
  print('  UnderlineInputBorder uses BorderStyle for the underline');
  print('  OutlineInputBorder uses BorderStyle for the outline');
  print('  Both default to BorderStyle.solid');

  print('\n' + '=' * 50);
  print('BorderStyle test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'BorderStyle Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Values: ${BorderStyle.values.length}'),
      for (final v in BorderStyle.values)
        Text('  ${v.name} (${v.index})'),
      Text('BorderSide: controls line rendering'),
    ],
  );
}
