// ignore_for_file: avoid_print
// D4rt test script: Tests SemanticsFlags (deprecated alias) from dart:ui
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('SemanticsFlags test executing');

  // SemanticsFlag is the canonical type
  final flag1 = ui.SemanticsFlag.isButton;
  print('SemanticsFlag.isButton: $flag1');
  print('index: ${flag1.index}');

  final flag2 = ui.SemanticsFlag.isTextField;
  print('SemanticsFlag.isTextField: $flag2');

  // values
  final vals = ui.SemanticsFlag.values;
  print('values count: ${vals.length}');

  // Test multiple flags together via index
  print('isButton index: ${ui.SemanticsFlag.isButton.index}');
  print('isChecked index: ${ui.SemanticsFlag.isChecked.index}');
  print('isFocused index: ${ui.SemanticsFlag.isFocused.index}');

  print('SemanticsFlags test completed');
  return Column(mainAxisSize: MainAxisSize.min, children: [
    Text('SemanticsFlags Tests', style: TextStyle(fontWeight: FontWeight.bold)),
    Text('isButton: $flag1'),
    Text('isTextField: $flag2'),
    Text('Total: ${vals.length} flags'),
  ]);
}
