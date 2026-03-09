// D4rt test script: Tests SystemColor from dart:ui
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('SystemColor test executing');

  final color1 = Color(0xFF00FF00);
  final sc1 = ui.SystemColor(name: 'testColor', value: color1);
  print('SystemColor name: ${sc1.name}');
  print('isSupported: ${sc1.isSupported}');

  final color2 = Color(0xFFFF0000);
  final sc2 = ui.SystemColor(name: 'accent', value: color2);
  print('sc2 name: ${sc2.name}');

  print('platformProvidesSystemColors: ${ui.SystemColor.platformProvidesSystemColors}');

  print('SystemColor test completed');
  return Column(mainAxisSize: MainAxisSize.min, children: [
    Text('SystemColor Tests', style: TextStyle(fontWeight: FontWeight.bold)),
    Text('Custom: ${sc1.name}'),
    Text('isSupported: ${sc1.isSupported}'),
  ]);
}
