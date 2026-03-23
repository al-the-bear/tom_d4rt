// ignore_for_file: avoid_print
// D4rt test script: Tests SemanticsUpdate from dart:ui
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('SemanticsUpdate test executing');

  // SemanticsUpdate obtained from SemanticsUpdateBuilder
  final builder = ui.SemanticsUpdateBuilder();
  final update = builder.build();
  print('SemanticsUpdate type: ${update.runtimeType}');

  // dispose
  update.dispose();
  print('Disposed');

  // Build another
  final b2 = ui.SemanticsUpdateBuilder();
  final u2 = b2.build();
  print('Second update: ${u2.runtimeType}');
  u2.dispose();

  print('SemanticsUpdate test completed');
  return Column(mainAxisSize: MainAxisSize.min, children: [
    Text('SemanticsUpdate Tests', style: TextStyle(fontWeight: FontWeight.bold)),
    Text('Created from SemanticsUpdateBuilder.build()'),
    Text('dispose() OK'),
  ]);
}
