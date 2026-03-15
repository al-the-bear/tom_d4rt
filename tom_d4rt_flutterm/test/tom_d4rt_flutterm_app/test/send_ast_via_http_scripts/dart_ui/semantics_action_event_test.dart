import 'dart:ui' as ui;

import 'package:flutter/material.dart';

Widget _eventCard(String title, ui.SemanticsActionEvent event, Color color) {
  return Expanded(
    child: Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withAlpha(26),
        border: Border.all(color: color),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 6),
          Text('Action: ${event.type.name}'),
          Text('View: ${event.viewId}'),
          Text('Node: ${event.nodeId}'),
          Text('Args: ${event.arguments}'),
        ],
      ),
    ),
  );
}

dynamic build(BuildContext context) {
  const original = ui.SemanticsActionEvent(
    type: ui.SemanticsAction.tap,
    viewId: 7,
    nodeId: 42,
    arguments: <String, Object?>{'source': 'script', 'count': 1},
  );
  final copied = original.copyWith(type: ui.SemanticsAction.longPress, nodeId: 100);

  return Padding(
    padding: const EdgeInsets.all(16),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('SemanticsActionEvent Visual Test', style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        Row(
          children: [
            _eventCard('Original', original, Colors.blue),
            const SizedBox(width: 10),
            _eventCard('copyWith()', copied, Colors.deepOrange),
          ],
        ),
        const SizedBox(height: 10),
        Text('Available actions: ${ui.SemanticsAction.values.length}'),
      ],
    ),
  );
}