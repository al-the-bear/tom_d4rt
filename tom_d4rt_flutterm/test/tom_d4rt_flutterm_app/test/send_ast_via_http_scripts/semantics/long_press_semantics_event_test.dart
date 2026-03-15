import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';

dynamic build(BuildContext context) {
  const event = LongPressSemanticsEvent();

  return Padding(
    padding: const EdgeInsets.all(16),
    child: Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.purple.withAlpha(24),
        border: Border.all(color: Colors.purple),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('LongPressSemanticsEvent Visual Test', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          const Icon(Icons.touch_app, color: Colors.purple, size: 28),
          const SizedBox(height: 8),
          Text('Type: ${event.type}'),
          Text('Runtime: ${event.runtimeType}'),
        ],
      ),
    ),
  );
}