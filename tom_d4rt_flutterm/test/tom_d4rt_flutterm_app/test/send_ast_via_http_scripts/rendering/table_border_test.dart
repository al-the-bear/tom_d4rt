// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests TableBorder from rendering
import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('TableBorder test executing');
  print('=' * 50);

  // TableBorder class overview
  print('TableBorder class overview:');
  print('  - Describes borders for Table widget');
  print('  - Supports outer and inner borders');
  print('  - Customizable per side');

  // Constructors
  print('\nConstructors:');
  print('  TableBorder()');
  print('    - All borders configurable');
  print('  TableBorder.all()');
  print('    - Uniform border all sides');
  print('  TableBorder.symmetric()');
  print('    - Same inside/outside');

  // Create with all
  print('\nCreate with TableBorder.all:');
  final borderAll = TableBorder.all(color: Colors.grey, width: 1.0);
  print('  borderAll created');
  print('  Has all borders with uniform style');

  // Create symmetric
  print('\nCreate TableBorder.symmetric:');
  final borderSym = TableBorder.symmetric(
    inside: BorderSide(color: Colors.grey, width: 0.5),
    outside: BorderSide(color: Colors.black, width: 2.0),
  );
  print('  borderSym created');
  print('  Inside and outside different');

  // Properties
  print('\nProperties:');
  print('  top: BorderSide (top edge)');
  print('  right: BorderSide (right edge)');
  print('  bottom: BorderSide (bottom edge)');
  print('  left: BorderSide (left edge)');
  print('  horizontalInside: BorderSide');
  print('  verticalInside: BorderSide');
  print('  borderRadius: BorderRadius');

  // Dimensions
  print('\nDimensions:');
  print('  dimensions: EdgeInsets');
  print('    - Size of border area');
  print('  isUniform: bool');
  print('    - All sides same?');

  // Usage context
  print('\nUsage context:');
  print('  Table.border');
  print('  DataTable styling');
  print('  Custom table layouts');

  // Scale method
  print('\nScale method:');
  print('  scale(double t)');
  print('  Returns scaled copy');

  // Lerp
  print('\nLerp:');
  print('  TableBorder.lerp(a, b, t)');
  print('  Interpolates borders');

  print('\n' + '=' * 50);
  print('TableBorder test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('TableBorder Tests', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      SizedBox(height: 8),
      Text('Type: Class'),
      Text('Key: all(), symmetric()'),
      Text('Purpose: Table border styling'),
    ],
  );
}
