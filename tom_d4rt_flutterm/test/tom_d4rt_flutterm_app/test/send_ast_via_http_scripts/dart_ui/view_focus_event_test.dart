// ignore_for_file: avoid_print
// D4rt test script: Tests ViewFocusEvent from dart:ui
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('ViewFocusEvent test executing');

  final event1 = ui.ViewFocusEvent(
    viewId: 0,
    state: ui.ViewFocusState.focused,
    direction: ui.ViewFocusDirection.forward,
  );
  print('ViewFocusEvent: viewId=${event1.viewId}');
  print('state: ${event1.state}');
  print('direction: ${event1.direction}');

  final event2 = ui.ViewFocusEvent(
    viewId: 1,
    state: ui.ViewFocusState.unfocused,
    direction: ui.ViewFocusDirection.backward,
  );
  print('Unfocused: state=${event2.state}, dir=${event2.direction}');

  // Enums
  for (final s in ui.ViewFocusState.values) { print('ViewFocusState: ${s.name}'); }
  for (final d in ui.ViewFocusDirection.values) { print('ViewFocusDirection: ${d.name}'); }

  print('ViewFocusEvent test completed');
  return Column(mainAxisSize: MainAxisSize.min, children: [
    Text('ViewFocusEvent Tests', style: TextStyle(fontWeight: FontWeight.bold)),
    Text('focused: ${event1.state}'),
    Text('unfocused: ${event2.state}'),
  ]);
}
