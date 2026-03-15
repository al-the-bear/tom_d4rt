import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';

dynamic build(BuildContext context) {
  final binding = SemanticsBinding.instance;
  final handle = binding.ensureSemantics();
  final handleType = handle.runtimeType;
  handle.dispose();

  final configuration = SemanticsConfiguration()
    ..label = 'Accessible Button'
    ..isSemanticBoundary = true
    ..isButton = true;

  return Center(
    child: Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('SemanticsHandle Visual Test', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            Row(
              children: [
                const Icon(Icons.accessibility_new, color: Colors.blue),
                const SizedBox(width: 8),
                Expanded(child: Text('Handle type: $handleType')),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.smart_button, color: Colors.green),
                const SizedBox(width: 8),
                Expanded(child: Text('Label: ${configuration.label}')),
              ],
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                Chip(label: Text('Boundary: ${configuration.isSemanticBoundary}')),
                Chip(label: Text('Button: ${configuration.isButton}')),
                Chip(label: Text('Actions: ${SemanticsAction.values.length}')),
                Chip(label: Text('Flags: ${SemanticsFlag.values.length}')),
                Chip(label: Text('Binding: ${binding.runtimeType}')),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}