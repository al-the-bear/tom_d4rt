import 'package:flutter/material.dart';

/// Deep visual demo for InputDecorator widget.
/// Shows the widget that renders InputDecoration around a child.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('InputDecorator', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(height: 16),
      // Anatomy diagram
      Container(
        width: 220,
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              color: Colors.white,
              child: const Text('Label', style: TextStyle(fontSize: 9, color: Colors.blue)),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                    decoration: BoxDecoration(color: Colors.orange.shade100, borderRadius: BorderRadius.circular(4)),
                    child: const Text('prefix', style: TextStyle(fontSize: 8)),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                      decoration: BoxDecoration(color: Colors.green.shade100, borderRadius: BorderRadius.circular(4)),
                      child: const Text('CHILD', textAlign: TextAlign.center, style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                    decoration: BoxDecoration(color: Colors.orange.shade100, borderRadius: BorderRadius.circular(4)),
                    child: const Text('suffix', style: TextStyle(fontSize: 8)),
                  ),
                ],
              ),
            ),
            const Text('  Helper text', style: TextStyle(fontSize: 9, color: Colors.grey)),
          ],
        ),
      ),
      const SizedBox(height: 12),
      const Text('Renders decoration around any child', style: TextStyle(fontSize: 11, color: Colors.grey)),
    ],
  );
}
