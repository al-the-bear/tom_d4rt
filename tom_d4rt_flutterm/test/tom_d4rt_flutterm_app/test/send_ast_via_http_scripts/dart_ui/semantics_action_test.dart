// D4rt test script: Tests SemanticsAction from dart:ui
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('SemanticsAction test executing');

  // All predefined actions
  final actions = [
    SemanticsAction.tap,
    SemanticsAction.longPress,
    SemanticsAction.scrollLeft,
    SemanticsAction.scrollRight,
    SemanticsAction.scrollUp,
    SemanticsAction.scrollDown,
    SemanticsAction.increase,
    SemanticsAction.decrease,
    SemanticsAction.copy,
    SemanticsAction.cut,
    SemanticsAction.paste,
    SemanticsAction.dismiss,
    SemanticsAction.moveCursorForwardByCharacter,
    SemanticsAction.moveCursorBackwardByCharacter,
    SemanticsAction.setText,
    SemanticsAction.focus,
  ];
  print('SemanticsAction count: ${actions.length}');
  for (final a in actions) {
    print('  action: $a');
  }

  // values map
  print('SemanticsAction.values: ${SemanticsAction.values.length} entries');
  print('tap index: ${SemanticsAction.tap.index}');

  print('SemanticsAction test completed');
  return Column(mainAxisSize: MainAxisSize.min, children: [
    Text('SemanticsAction Tests', style: TextStyle(fontWeight: FontWeight.bold)),
    Text('${actions.length} actions tested'),
    Text('values map: ${SemanticsAction.values.length} entries'),
  ]);
}
