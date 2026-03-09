// D4rt test script: Tests SemanticsAction from dart:ui
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('SemanticsAction test executing');

  // All predefined actions
  final actions = [
    ui.SemanticsAction.tap,
    ui.SemanticsAction.longPress,
    ui.SemanticsAction.scrollLeft,
    ui.SemanticsAction.scrollRight,
    ui.SemanticsAction.scrollUp,
    ui.SemanticsAction.scrollDown,
    ui.SemanticsAction.increase,
    ui.SemanticsAction.decrease,
    ui.SemanticsAction.copy,
    ui.SemanticsAction.cut,
    ui.SemanticsAction.paste,
    ui.SemanticsAction.dismiss,
    ui.SemanticsAction.moveCursorForwardByCharacter,
    ui.SemanticsAction.moveCursorBackwardByCharacter,
    ui.SemanticsAction.setText,
    ui.SemanticsAction.focus,
  ];
  print('SemanticsAction count: ${actions.length}');
  for (final a in actions) {
    print('  action: $a');
  }

  // values map
  print('SemanticsAction.values: ${ui.SemanticsAction.values.length} entries');
  print('tap index: ${ui.SemanticsAction.tap.index}');

  print('SemanticsAction test completed');
  return Column(mainAxisSize: MainAxisSize.min, children: [
    Text('SemanticsAction Tests', style: TextStyle(fontWeight: FontWeight.bold)),
    Text('${actions.length} actions tested'),
    Text('values map: ${ui.SemanticsAction.values.length} entries'),
  ]);
}
