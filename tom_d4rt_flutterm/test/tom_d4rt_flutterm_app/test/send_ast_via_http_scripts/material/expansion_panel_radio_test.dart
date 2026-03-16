import 'package:flutter/material.dart';

/// Deep visual demo for ExpansionPanelRadio - single-select expansion panels.
/// Shows accordion-style panels where only one can be expanded.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('ExpansionPanelRadio', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(height: 16),
      Container(
        width: 250,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
        ),
        child: Column(
          children: [
            // Panel 1 (expanded)
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(children: [const Text('Panel 1', style: TextStyle(fontWeight: FontWeight.bold)), const Spacer(), const Icon(Icons.expand_less, color: Colors.blue)]),
                  const Divider(),
                  const Text('Expanded content here', style: TextStyle(fontSize: 11)),
                ],
              ),
            ),
            // Panel 2 (collapsed)
            Container(
              padding: const EdgeInsets.all(12),
              child: const Row(children: [Text('Panel 2'), Spacer(), Icon(Icons.expand_more)]),
            ),
            const Divider(height: 1),
            // Panel 3 (collapsed)
            Container(
              padding: const EdgeInsets.all(12),
              decoration: const BoxDecoration(borderRadius: BorderRadius.vertical(bottom: Radius.circular(8))),
              child: const Row(children: [Text('Panel 3'), Spacer(), Icon(Icons.expand_more)]),
            ),
          ],
        ),
      ),
      const SizedBox(height: 12),
      const Text('Only one panel expanded at a time', style: TextStyle(fontSize: 11, color: Colors.grey)),
    ],
  );
}
