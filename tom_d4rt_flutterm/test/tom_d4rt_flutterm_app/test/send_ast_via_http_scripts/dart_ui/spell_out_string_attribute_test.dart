// D4rt test script: Tests SpellOutStringAttribute from dart:ui
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('SpellOutStringAttribute test executing');

  final attr1 = ui.SpellOutStringAttribute(range: TextRange(start: 0, end: 5));
  print('SpellOutStringAttribute: ${attr1.runtimeType}');
  print('range: start=${attr1.range.start}, end=${attr1.range.end}');

  final attr2 = ui.SpellOutStringAttribute(range: TextRange(start: 10, end: 20));
  print('attr2 range: ${attr2.range}');

  // Is StringAttribute subtype
  print('is StringAttribute: ${attr1 is ui.StringAttribute}');

  print('SpellOutStringAttribute test completed');
  return Column(mainAxisSize: MainAxisSize.min, children: [
    Text('SpellOutStringAttribute Tests', style: TextStyle(fontWeight: FontWeight.bold)),
    Text('range: ${attr1.range}'),
    Text('is StringAttribute: ${attr1 is ui.StringAttribute}'),
  ]);
}
