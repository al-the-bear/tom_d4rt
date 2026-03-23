// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests DoubleProperty from foundation
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('DoubleProperty test executing');

  final dp1 = DoubleProperty('width', 100.5);
  print('DoubleProperty: ${dp1.name}=${dp1.value}');
  print('toString: ${dp1.toString()}');

  final dp2 = DoubleProperty('opacity', 0.75, unit: '%');
  print('dp2: ${dp2.toString()}');

  final dp3 = DoubleProperty('height', null, ifNull: 'unbounded');
  print('dp3 null: ${dp3.toString()}');

  final dp4 = DoubleProperty('scale', 1.0, defaultValue: 1.0);
  print('dp4 default: ${dp4.toString()}');
  print('dp4 isFiltered(info): ${dp4.isFiltered(DiagnosticLevel.info)}');

  print('DoubleProperty test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'DoubleProperty Tests',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      Text('width: ${dp1.toString()}'),
      Text('opacity: ${dp2.toString()}'),
      Text('null: ${dp3.toString()}'),
    ],
  );
}
