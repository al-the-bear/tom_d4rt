// D4rt test script: Tests SemanticsUpdateBuilder from dart:ui
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('SemanticsUpdateBuilder test executing');

  final builder = ui.SemanticsUpdateBuilder();
  print('SemanticsUpdateBuilder: ${builder.runtimeType}');

  // build — produces SemanticsUpdate
  final update = builder.build();
  print('SemanticsUpdate: ${update.runtimeType}');
  update.dispose();
  print('SemanticsUpdate disposed');

  // New builder
  final builder2 = ui.SemanticsUpdateBuilder();
  final update2 = builder2.build();
  print('Second update: ${update2.runtimeType}');
  update2.dispose();

  print('SemanticsUpdateBuilder test completed');
  return Column(mainAxisSize: MainAxisSize.min, children: [
    Text('SemanticsUpdateBuilder Tests', style: TextStyle(fontWeight: FontWeight.bold)),
    Text('Created builder + built update'),
    Text('dispose() called on updates'),
  ]);
}
