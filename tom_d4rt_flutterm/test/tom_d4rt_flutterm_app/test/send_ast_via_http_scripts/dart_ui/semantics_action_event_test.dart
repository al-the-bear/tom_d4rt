// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests SemanticsActionEvent from dart:ui
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('SemanticsActionEvent test executing');

  final event1 = ui.SemanticsActionEvent(
    type: ui.SemanticsAction.tap,
    viewId: 0,
    nodeId: 1,
  );
  print('SemanticsActionEvent: type=${event1.type}, viewId=${event1.viewId}, nodeId=${event1.nodeId}');
  print('arguments: ${event1.arguments}');

  // With arguments
  final event2 = ui.SemanticsActionEvent(
    type: ui.SemanticsAction.scrollUp,
    viewId: 0,
    nodeId: 2,
  );
  print('ScrollUp event: type=${event2.type}');

  // copyWith
  final event3 = event1.copyWith(nodeId: 42);
  print('copyWith nodeId: ${event3.nodeId}');
  print('copyWith type unchanged: ${event3.type}');

  print('SemanticsActionEvent test completed');
  return Column(mainAxisSize: MainAxisSize.min, children: [
    Text('SemanticsActionEvent Tests', style: TextStyle(fontWeight: FontWeight.bold)),
    Text('tap: nodeId=${event1.nodeId}'),
    Text('scrollUp: nodeId=${event2.nodeId}'),
    Text('copyWith: nodeId=${event3.nodeId}'),
  ]);
}
