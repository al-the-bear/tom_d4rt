// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests DiagnosticsProperty from foundation
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('DiagnosticsProperty test executing');

  final dp1 = DiagnosticsProperty<String>('name', 'hello');
  print('DiagnosticsProperty: name=${dp1.name}, value=${dp1.value}');
  print('level: ${dp1.level}');
  print('isFiltered: ${dp1.isFiltered(DiagnosticLevel.info)}');

  final dp2 = DiagnosticsProperty<int>('count', 42, defaultValue: 0);
  print('dp2: ${dp2.value}, default=${dp2.defaultValue}');

  final dp3 = DiagnosticsProperty<String>('nullable', null, ifNull: 'not set');
  print('dp3 null: value=${dp3.value}, ifNull=${dp3.ifNull}');

  // toString
  print('dp1 toString: ${dp1.toString()}');
  print('dp2 toString: ${dp2.toString()}');

  print('DiagnosticsProperty test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'DiagnosticsProperty Tests',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      Text('String: ${dp1.toString()}'),
      Text('Int: ${dp2.toString()}'),
      Text('Null: ${dp3.toString()}'),
    ],
  );
}
